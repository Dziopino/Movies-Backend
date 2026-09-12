const cloudinary = require('cloudinary').v2;
const mysql = require('mysql');
const path = require('path');
const fs = require('fs');
require('dotenv').config();

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

const connection = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'movies',
    port: process.env.DB_PORT || 3306
});

function query(sql, params) {
    return new Promise((resolve, reject) => {
        connection.query(sql, params || [], (err, results) => {
            if (err) reject(err);
            else resolve(results);
        });
    });
}

function uploadFile(filePath, folder, publicId) {
    return new Promise((resolve, reject) => {
        cloudinary.uploader.upload(filePath, {
            folder,
            public_id: publicId,
            resource_type: 'image',
            overwrite: true
        }, (error, result) => {
            if (error) reject(error);
            else resolve(result);
        });
    });
}

async function migrate() {
    console.log('Starting migration to Cloudinary...\n');

    const users = await query(
        "SELECT id, avatar_url FROM users WHERE avatar_url IS NOT NULL AND avatar_url LIKE '/uploads/%'"
    );

    console.log(`Found ${users.length} avatars to migrate`);
    for (const user of users) {
        const localPath = path.join(__dirname, '..', user.avatar_url);
        if (!fs.existsSync(localPath)) {
            console.log(`  SKIP user ${user.id}: file not found at ${localPath}`);
            continue;
        }
        try {
            const fileName = path.basename(user.avatar_url, path.extname(user.avatar_url));
            const result = await uploadFile(localPath, 'cinemix/avatars', fileName);
            await query("UPDATE users SET avatar_url = ? WHERE id = ?", [result.secure_url, user.id]);
            console.log(`  OK user ${user.id}: ${result.secure_url}`);
        } catch (err) {
            console.error(`  ERROR user ${user.id}:`, err.message);
        }
    }

    const films = await query(
        "SELECT id, poster_url FROM films WHERE poster_url IS NOT NULL AND poster_url LIKE '/uploads/%'"
    );

    console.log(`\nFound ${films.length} posters to migrate`);
    for (const film of films) {
        const localPath = path.join(__dirname, '..', film.poster_url);
        if (!fs.existsSync(localPath)) {
            console.log(`  SKIP film ${film.id}: file not found at ${localPath}`);
            continue;
        }
        try {
            const fileName = path.basename(film.poster_url, path.extname(film.poster_url));
            const result = await uploadFile(localPath, 'cinemix/posters', fileName);
            await query("UPDATE films SET poster_url = ? WHERE id = ?", [result.secure_url, film.id]);
            console.log(`  OK film ${film.id}: ${result.secure_url}`);
        } catch (err) {
            console.error(`  ERROR film ${film.id}:`, err.message);
        }
    }

    const guestPath = path.join(__dirname, '..', 'uploads', 'posters', 'guest.webp');
    if (fs.existsSync(guestPath)) {
        try {
            const result = await uploadFile(guestPath, 'cinemix/posters', 'guest');
            console.log(`\nDefault guest avatar uploaded: ${result.secure_url}`);
        } catch (err) {
            console.error('Error uploading guest avatar:', err.message);
        }
    }

    console.log('\nMigration complete!');
    connection.end();
}

migrate().catch(err => {
    console.error('Migration failed:', err);
    connection.end();
    process.exit(1);
});
