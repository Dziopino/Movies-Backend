import { describe, it, expect, beforeEach } from 'vitest';
import request from 'supertest';

// Importujemy prawdziwą aplikację z server.js
// UWAGA: Te testy wykonują prawdziwe zapytania do bazy danych
// W przyszłości można dodać osobną testową bazę danych
const app = (await import('../server.js')).default;

describe('Server Endpoints - Integration Tests', () => {

    describe('GET /api/getLanguageCodes', () => {

        it('should return list of available language codes', async () => {

            const response = await request(app)
                .get('/api/getLanguageCodes');

            expect(response.status).toBe(200);
            expect(response.body.message).toContain('Language codes got successfully');
            expect(Array.isArray(response.body.body)).toBe(true);
            expect(response.body.body.length).toBeGreaterThan(0);

            // Sprawdzamy, czy są podstawowe języki
            const codes = response.body.body.map(lang => lang.code);
            expect(codes).toContain('en');
            expect(codes).toContain('pl');
        });
    });

    describe('POST /api/addUser', () => {

        it('should reject registration with invalid password', async () => {

            const response = await request(app)
                .post('/api/addUser')
                .send({
                    username: 'testuser',
                    email: 'test@example.com',
                    password: 'short' // Za krótkie hasło
                });

            expect(response.status).toBe(400);
            expect(response.body.success).toBe(false);
            expect(response.body.message).toBe('Password requirements not met');
        });

        it('should reject registration with missing fields', async () => {

            const response = await request(app)
                .post('/api/addUser')
                .send({
                    username: 'testuser'
                    // Brak email i password
                });

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(false);
            expect(response.body.message).toBe('Invalid input data');
        });

        it('should reject registration with missing password', async () => {

            const response = await request(app)
                .post('/api/addUser')
                .send({
                    username: 'testuser',
                    email: 'test@example.com'
                    // Brak password
                });

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(false);
            expect(response.body.message).toBe('Invalid input data');
        });
    });

    describe('GET /api/getFilm/:id', () => {

        it('should return film details for existing film', async () => {

            // Testujemy z filmem ID 5 (zakładamy, że istnieje w bazie)
            const response = await request(app)
                .get('/api/getFilm/5')
                .query({ language: 'en' });

            expect(response.status).toBe(200);
            expect(response.body.body).toBeDefined();

            // Sprawdzamy strukturę odpowiedzi
            const film = response.body.body;
            expect(film).toHaveProperty('id');
            expect(film).toHaveProperty('title');
            expect(film).toHaveProperty('description');
            expect(film).toHaveProperty('poster_url');
            expect(film).toHaveProperty('rating');
            expect(film).toHaveProperty('duration');
        });

        it('should work without authentication', async () => {

            // Ten endpoint powinien działać bez tokena (optional auth)
            const response = await request(app)
                .get('/api/getFilm/5')
                .query({ language: 'en' });

            expect(response.status).toBe(200);
            expect(response.body.body).toBeDefined();
        });

        it('should use default language for invalid language code', async () => {

            const response = await request(app)
                .get('/api/getFilm/5')
                .query({ language: 'invalid_xyz' });

            // Powinno zwrócić film z domyślnym językiem (en)
            expect(response.status).toBe(200);
            expect(response.body.body).toBeDefined();
        });
    });

    describe('POST /api/getFilms', () => {

        it('should return list of films without authentication', async () => {

            const response = await request(app)
                .post('/api/getFilms')
                .send({
                    language: 'en',
                    page: 1
                });

            expect(response.status).toBe(200);
            expect(response.body.message).toBe('Films got successfully');
            expect(Array.isArray(response.body.body)).toBe(true);
            expect(response.body).toHaveProperty('totalPages');
        });

        it('should support pagination', async () => {

            const response = await request(app)
                .post('/api/getFilms')
                .send({
                    language: 'en',
                    page: 2
                });

            expect(response.status).toBe(200);
            expect(response.body.message).toBe('Films got successfully');
            expect(response.body).toHaveProperty('totalPages');
        });

        it('should use default language when not specified', async () => {

            const response = await request(app)
                .post('/api/getFilms')
                .send({
                    page: 1
                });

            expect(response.status).toBe(200);
            expect(response.body.message).toBe('Films got successfully');
        });
    });

    describe('Server health', () => {

        it('should respond to GET /api/getLanguageCodes without crashing', async () => {

            const response = await request(app)
                .get('/api/getLanguageCodes');

            expect(response.status).toBe(200);
        });

        it('should handle unknown routes gracefully', async () => {

            const response = await request(app)
                .get('/nonexistent-endpoint');

            // Express zwraca 404 dla nieistniejących tras
            expect([404, 200]).toContain(response.status);
        });
    });
});
