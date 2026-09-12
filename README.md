<div align="center">

# ⚙️ CINEMIX — Backend API

### Enterprise REST API & Data Layer for Cinemix Platform

[![Node.js](https://img.shields.io/badge/Node.js-Express-339933?logo=node.js&logoColor=white)](https://nodejs.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![JWT](https://img.shields.io/badge/JWT-auth-000000?logo=jsonwebtokens&logoColor=white)](https://jwt.io/)
[![bcrypt](https://img.shields.io/badge/bcrypt-hashing-6A5ACD)](https://www.npmjs.com/package/bcrypt)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-image_storage-3448C5?logo=cloudinary&logoColor=white)](https://cloudinary.com/)

**Express · MySQL · JWT · bcrypt · RBAC · Cloudinary · Server-Side Pagination**

[Frontend Repo](https://github.com/Dziopino/Movies-Frontend) · [Backend Repo](https://github.com/Dziopino/Movies-Backend) · [Live Demo](https://cinemix.xyz) · [API Docs](#-api-reference)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Project Status](#-project-status)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Security Model](#-security-model)
- [Database Schema](#-database-schema)
- [Middleware Pipeline](#-middleware-pipeline)
- [API Reference](#-api-reference)
- [Key Features](#-key-features)
- [Project Structure](#-project-structure)
- [Roadmap](#-roadmap)
- [Getting Started](#-getting-started)
- [Environment Variables](#-environment-variables)
- [Author](#-author)

---

## 🎯 Overview

The **Cinemix Backend** is a stateless REST API built on Node.js and Express, serving as the data and authentication backbone for the Cinemix movie management platform. It enforces **Role-Based Access Control (RBAC)**, handles **JWT session management**, processes **image uploads** with real-time compression, and orchestrates all database operations through a normalized MySQL relational schema.

This repository is designed to pair with the [Movies-Frontend](https://github.com/Dziopino/Movies-Frontend) React application, communicating exclusively over HTTP via JSON payloads.

---

## 🚧 Project Status

> **Current Phase:** Active Development (v0.8 Beta)
>
> Core API is production-stable: authentication, user lifecycle management, film catalog serving, watchlist operations, genre administration, and password reset flows are fully operational. The codebase is currently evolving toward a modular controller-based architecture and expanding its observability surface.
>
> See the [Roadmap](#-roadmap) for planned architectural upgrades.

---

## 🛠 Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| **Node.js** | LTS | Runtime environment |
| **Express** | ~4.16.1 | HTTP server & routing framework |
| **MySQL** | ^2.18.1 | Relational database driver (mysql package) |
| **JWT** | ^9.0.3 | Stateless authentication tokens |
| **bcrypt** | ^6.0.0 | Secure password hashing (salted) |
| **multer** | ^2.2.0 | In-memory multipart upload handling |
| **sharp** | ^0.35.2 | High-performance image processing (WebP compression) |
| **cloudinary** | ^2.6.0 | Cloud image storage, delivery, and lifecycle management |
| **resend** | ^6.26.0 | HTTPS-based transactional email API (replaces SMTP) |
| **helmet** | ^8.3.0 | HTTP security headers (CSP, HSTS, X-Frame-Options) |
| **express-rate-limit** | ^8.7.0 | API rate limiting (global: 750 req/15min, auth: 10 req/15min) |
| **crypto** | ^1.0.1 | Cryptographic token generation (password reset) |
| **dotenv** | ^17.4.2 | Environment variable management |
| **cors** | ^2.8.6 | Cross-Origin Resource Sharing policy |
| **cookie-parser** | ~1.4.4 | Cookie parsing middleware |
| **morgan** | ~1.9.1 | HTTP request logging |
| **vitest** | ^4.1.10 | Unit/integration testing framework (dev) |
| **supertest** | ^7.2.2 | HTTP assertion library for API testing (dev) |

---

## 🏗 Architecture

```
┌────────────────────────────────────────────┐
│              HTTP Request                  │
│  (JSON / multipart / Bearer Token)         │
└──────────────┬─────────────────────────────┘
               │
               ▼
┌────────────────────────────────────────────┐
│           Express Router                   │
│  ┌─────────────────────────────────────┐   │
│  │  optionalAuthMiddleware             │   │
│  │  ├─ attaches req.user OR null       │   │
│  │  └─ passes through for public data  │   │
│  └─────────────────────────────────────┘   │
│  ┌─────────────────────────────────────┐   │
│  │  authMiddleware                     │   │
│  │  ├─ verifies JWT signature          │   │
│  │  ├─ checks BANNED / SUSPENDED       │   │
│  │  └─ auto-reverts expired suspensions│   │
│  └─────────────────────────────────────┘   │
│  ┌─────────────────────────────────────┐   │
│  │  adminMiddleware                    │   │
│  │  └─ enforces role === 1             │   │
│  └─────────────────────────────────────┘   │
│               │                            │
│               ▼                            │
│  ┌─────────────────────────────────────┐   │
│  │  Route Handler (server.js)          │   │
│  │  ├─ validation & sanitization       │   │
│  │  ├─ business logic                  │   │
│  │  └─ SQL query execution             │   │
│  └─────────────────────────────────────┘   │
│               │                            │
│               ▼                            │
│         MySQL Connection Pool              │
└────────────────────────────────────────────┘
```

---

## 🔐 Security Model

### Layered Authentication
The API implements a **three-tier middleware cascade** that progressively escalates privileges:

1. **`optionalAuthMiddleware`** — Parses JWT if present; attaches `req.user` or `null`. Used for public catalog endpoints that conditionally expose user-specific state (e.g., favorite status).
2. **`authMiddleware`** — Mandates a valid, non-expired JWT. Performs real-time account status reconciliation: if a suspended account's `suspended_until` has elapsed, it is automatically reactivated before the request proceeds.
3. **`adminMiddleware`** — Validates `req.user.role === 1`. Rejects non-administrators with `403 Forbidden`.

### Password Security
- **Registration / Reset**: Passwords are hashed with `bcrypt` (salted, adaptive cost factor) before persistence.
- **Admin Action Verification**: Sensitive mutations (promote user, delete genre, delete film) require the administrator to re-submit their own password. The backend performs a live `bcrypt.compare` against the stored hash before executing the operation — mitigating session hijacking risks.

### Image Upload Pipeline
- **multer** accepts files into memory (`memoryStorage`) — no temporary disk writes.
- **File filter** rejects non-image MIME types.
- **Size cap**: 2 MB hard limit (`MulterError` handling).
- **sharp** resizes images in-memory:
    - **Avatars**: 300×300 cover-fit, WebP quality 80
    - **Film posters**: 200×285 cover-fit, WebP quality 90
- **Cloudinary upload**: Compressed buffers are streamed directly to Cloudinary via `upload_stream` (no local file writes).
- **Old image cleanup**: On avatar replacement, film poster replacement, or film deletion, the previous Cloudinary asset is destroyed via `deleteFromCloudinary` to prevent storage bloat.
- **URL resolution**: All image URLs returned by the API are full Cloudinary HTTPS URLs. The frontend uses a `resolveImageUrl()` helper for backward compatibility with any legacy local paths.

### Token-Based Password Reset
- **Generation**: `crypto.randomBytes(32)` produces a 64-character hex token.
- **Expiry**: 15-minute window (`reset_token_expiry`).
- **Delivery**: Resend API dispatches reset links via HTTPS (port 443) from custom domain `noreply@cinemix.xyz`. Bypasses SMTP port restrictions on cloud platforms like Render.
- **Invalidation**: Token is nulled immediately after a successful password change.
- **Error Handling**: Email delivery failures are logged but non-blocking — users receive success response even if email transmission fails, preventing UX degradation.

---

## 🗄 Database Schema

Normalized relational model with foreign key constraints, composite unique indexes, and `ON DELETE CASCADE` on junction tables.

### Core Tables

| Table | Purpose |
|-------|---------|
| **`users`** | Accounts, credentials, roles, statuses, localization |
| **`films`** | Base film metadata (poster, rating, release, duration) |
| **`film_translations`** | Localized titles & descriptions (1:N per film) |
| **`genres`** | Taxonomy of film genres |
| **`film_genres`** | Junction table: films ↔ genres (N:M) |
| **`languages`** | Supported locale codes |
| **`user_favorites`** | Watchlist: user ↔ film (unique composite) |
| **`user_watched`** | Viewed log: user ↔ film (unique composite) |

### User Status State Machine
```
ACTIVE ◄─────────────────────────────┐
  │                                  │
  │ ban()                            │ auto-expire
  ▼                                  │ or manual
BANNED ──unban()──► ACTIVE           │
  │                                  │
  │ suspend(until)                   │
  ▼                                  │
SUSPENDED ──unsuspend()──► ACTIVE    │
```

### Key Constraints
- `users.email` — `UNIQUE`
- `genres.name` — `UNIQUE` (normalized to lowercase)
- `film_translations(film_id, language_code)` — composite `UNIQUE`
- `user_favorites(user_id, film_id)` — composite `UNIQUE`
- `user_watched(user_id, film_id)` — composite `UNIQUE`
- `film_genres` — `ON DELETE CASCADE` (orphaned junction rows auto-cleaned)

---

## 🛡 Middleware Pipeline

| Middleware | File | Responsibility |
|------------|------|----------------|
| `optionalAuthMiddleware` | `middleware/optionalAuthMiddleware.js` | Decodes JWT without enforcing presence. Enables personalized public content. |
| `authMiddleware` | `middleware/authMiddleware.js` | Validates JWT signature, checks account status, auto-reverts expired suspensions, attaches `req.user`. |
| `adminMiddleware` | `middleware/adminMiddleware.js` | Guards admin-only routes. Returns `403` for non-administrators. |

### Utility Modules

| Utility | File | Purpose |
|---------|------|---------|
| `checkIfUserIsAdmin` | `utils/checkIfUserIsAdmin.js` | Async role lookup used before ban/suspend operations to prevent admin-on-admin actions. |
| `generateToken` | `utils/generateToken.js` | JWT signing with `id` payload and `JWT_SECRET`. |
| `hashPassword` | `utils/passwordHasher.js` | bcrypt wrapper with adaptive salt rounds. |
| `isPasswordValid` | `utils/passwordValidator.js` | Enforces complexity: ≥8 chars, uppercase, lowercase, digit, special character. |
| `loadLanguages` / `isLanguageValid` | `utils/languageValidator.js` | Caches language codes at boot time to avoid repeated DB hits. |
| `logActivity` | `utils/activityLogger.js` | Logs user/admin actions to `user_activity` table for audit trail. |
| `uploadToCloudinary` / `deleteFromCloudinary` | `utils/cloudinary.js` | Cloudinary SDK wrapper: buffer upload via `upload_stream` and asset deletion by URL parsing. |

---

## 📡 API Reference

### Authentication

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/checkLoginData` | — | Authenticate; returns JWT + user object. Handles BANNED / SUSPENDED states with auto-expiry logic. |
| `POST` | `/api/addUser` | — | Register new account. Validates password complexity, hashes with bcrypt, rejects duplicate emails. |
| `POST` | `/api/requestPasswordReset` | — | Generates crypto token, stores expiry, sends reset email via Resend API (HTTPS). Non-blocking: responds immediately even if email fails. |
| `GET` | `/api/getResetToken/:token` | — | Verifies token existence and expiry status. |
| `POST` | `/api/resetPassword/:token` | — | Validates token, hashes new password, nullifies token. |

### User Profile

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/getUserData` | JWT | Returns sanitized user profile (excludes password hash). |
| `POST` | `/api/getUserActivity` | JWT | Returns the user's latest activity events (login, avatar update, like, watch, language change) from `user_activity` table. |
| `POST` | `/api/editUserBio` | JWT | Updates biography text. |
| `POST` | `/api/editUserName` | JWT | Updates display name. |
| `POST` | `/api/changeUserLanguage` | JWT | Updates preferred UI locale; validated against cached language codes. |
| `POST` | `/api/uploadAvatar` | JWT + multer | Accepts image ≤2 MB; compresses to 300×300 WebP via sharp; uploads to Cloudinary; deletes old avatar from cloud. |

### Film Catalog (Public)

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/getFilms` | Optional | Paginated catalog (20/page) with optional `LIKE` search on localized titles and `genreName` filter (server-side via `HAVING` + `FIND_IN_SET`). Returns favorite/watched state if authenticated. |
| `GET` | `/getFilm/:id` | Optional | Single film detail with genre aggregation (`GROUP_CONCAT`) and user-specific state. |
| `GET` | `/getLanguageCodes` | — | Returns all supported language codes (cached at boot). |

### Watchlists

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/likeToggle` | JWT | Idempotent favorite toggle (INSERT or DELETE on `user_favorites`). |
| `POST` | `/watchedToggle` | JWT | Idempotent watched toggle (INSERT or DELETE on `user_watched`). |
| `POST` | `/likedGet` | JWT | Paginated favorites list with localized metadata and optional `genreName` filter. |
| `POST` | `/watchedGet` | JWT | Paginated watched list with localized metadata and optional `genreName` filter. |

### Admin — User Management

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/getUsers` | Admin | Paginated user directory (25/page) with role, status, and language joins. Searchable by ID, username, or email. |
| `GET` | `/refreshUser/:userId` | Admin | Returns refreshed user snapshot for UI reconciliation. |
| `POST` | `/banUser` | Admin | Sets `BANNED` status with reason, timestamp, and actor attribution. Clears any prior suspension data. |
| `POST` | `/suspendUser` | Admin | Sets `SUSPENDED` status with future expiry date, reason, and actor. Validates date is in the future. |
| `POST` | `/unBanUser` | Admin | Reverts `BANNED` → `ACTIVE`; clears ban metadata. |
| `POST` | `/unSuspendUser` | Admin | Reverts `SUSPENDED` → `ACTIVE`; clears suspension metadata. |
| `POST` | `/promoteUser` | Admin + password | Elevates user to `role = 1`. Requires admin password re-verification. |
| `POST` | `/checkSuspensions` | Admin | Batch operation: mass-reactivates all accounts where `suspended_until <= NOW()`. |

### Admin — Genre Management

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/getGenres` | Admin | Paginated genre list with per-genre film count (`COUNT` + `LEFT JOIN`). |
| `GET` | `/refreshGenre/:genreId` | Admin | Returns refreshed genre snapshot. |
| `POST` | `/addGenre` | Admin | Creates genre; normalizes name to lowercase; handles `ER_DUP_ENTRY`. |
| `POST` | `/editGenre` | Admin | Updates genre name; duplicate guard via `ER_DUP_ENTRY`. |
| `POST` | `/deleteGenre` | Admin + password | Deletes genre. `ON DELETE CASCADE` cleans `film_genres` junction automatically. |

### Admin — Film Management

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/getFilmsAdmin` | Admin | Admin-facing film list with localized titles and genre counts. |
| `GET` | `/getFilmTranslations/:id` | Admin | Returns all translations for a specific film with language codes, titles, and descriptions. |
| `GET` | `/getFilmGenres/:id` | Admin | Returns all genres assigned to a specific film. |
| `GET` | `/getAllGenresList` | Admin | Returns complete list of all available genres for film assignment. |
| `POST` | `/addFilm` | Admin + multer | Creates film with multipart poster upload (sharp → 200×285 WebP → Cloudinary), metadata validation (rating 1-10, duration), multi-language translations, genre associations, and duplicate language prevention. |
| `PUT` | `/updateFilm/:id` | Admin + multer | Updates film metadata (rating, release date, duration), optionally uploads new poster to Cloudinary (deletes old), replaces all translations, and reassigns genres. Uses SQL transactions for atomic updates. |
| `POST` | `/deleteFilm` | Admin + password | Deletes film record and its poster from Cloudinary. Requires admin password re-verification. |
| `POST` | `/addAdmin` | Admin | Creates new user with `role = 1` directly. Validates password complexity and email uniqueness. |

### Admin — Dashboard Analytics

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/admin/dashboard/overview` | Admin | Dashboard overview with total counts: all films, all users, active users. |
| `GET` | `/api/admin/dashboard/films-analytics` | Admin | Film analytics data: top 10 popular films (by likes/watched), average rating with min/max range, films added in last week/month/year, genre distribution. |
| `GET` | `/api/admin/dashboard/users-analytics` | Admin | User analytics data: moderation stats (banned/suspended counts), 7-day registration trend chart data. |
| `GET` | `/api/admin/dashboard/audit-logs` | Admin | Paginated audit logs (50/page) with user actions: film liked/unliked/watched/unwatched, sorted by timestamp descending. |

---

## ✨ Key Features

### Server-Side Pagination, Search & Genre Filtering
All list endpoints (`getFilms`, `getUsers`, `getGenres`, `likedGet`, `watchedGet`, `audit-logs`) implement consistent pagination via `LIMIT`/`OFFSET` with parallel `COUNT(*)` queries for total page calculation. Search is delegated to SQL `LIKE` with parameterized values, preventing unbounded result sets from reaching the client. Film catalog endpoints additionally support server-side genre filtering via `genreName` parameter using `HAVING` + `FIND_IN_SET` on aggregated genre names, ensuring pagination counts reflect filtered results accurately.

### Activity Logging Architecture
Comprehensive audit trail implemented via `user_activity` table capturing 25+ distinct action types (e.g., `FILM_LIKED`, `USER_LOGGED_IN`, `USER_BANNED`) with associated `user_id` and timestamp. Used by both user profile history and admin dashboard analytics. Includes a dedicated endpoint for paginated and filterable administrative review.

### Auto-Expiry Suspension Engine
Suspended accounts do not require manual intervention to reactivate. The expiry is evaluated in two places:
1. **Login flow** (`/checkLoginData`) — checks `suspended_until` before issuing JWT.
2. **Request lifecycle** (`authMiddleware`) — re-evaluates on every authenticated request, updating the database atomically if the window has passed.

### Localized Response Architecture
The backend returns i18n **message keys** (e.g., `user_banned_successfully`, `database_error`) rather than hardcoded English strings. The React frontend translates these keys via `react-i18next`, enabling seamless multi-language support without backend redeployment.

### LEFT JOIN Integrity Fix
Early iterations used `INNER JOIN` when resolving film-genre relationships, which silently excluded films without genre assignments. The current implementation uses `LEFT JOIN` across all film queries, ensuring orphaned records remain visible in the catalog.

---

## 📁 Project Structure

```
backend/
├── bin/
│   └── www                     # Server bootstrap (port binding)
├── controllers/                # Request handlers (analytics)
│   └── analyticsController.js  # Dashboard analytics endpoints
├── middleware/
│   ├── authMiddleware.js       # JWT validation + status reconciliation
│   ├── adminMiddleware.js      # Role-based access enforcement
│   └── optionalAuthMiddleware.js # Guest-friendly auth parsing
├── utils/
│   ├── activityLogger.js       # User activity logging for audit trail
│   ├── checkIfUserIsAdmin.js   # Async role verification
│   ├── cloudinary.js           # Cloudinary SDK wrapper (upload/delete)
│   ├── generateToken.js        # JWT signing utility
│   ├── languageValidator.js    # Language cache + validation
│   ├── passwordHasher.js       # bcrypt hashing wrapper
│   └── passwordValidator.js    # Complexity rule engine
├── scripts/
│   └── migrate-to-cloudinary.js # One-time migration: local uploads → Cloudinary
├── database/
│   └── cinemix.sql             # Database schema
├── public/                     # Static assets (legacy)
├── routes/                     # Reserved for future controller extraction
├── views/                      # Pug templates (legacy / unused)
├── database.js                 # MySQL connection singleton
├── server.js                   # Main application — all routes & handlers
├── package.json
└── .env                        # Environment configuration (not tracked)
```

> **Note:** The current architecture consolidates most route handlers in `server.js`. Analytics endpoints are extracted to `controllers/analyticsController.js`. A full controller-based refactor is scheduled on the [Roadmap](#-roadmap) to improve maintainability at scale.

---

## 🗺 Roadmap

### Architecture & Maintainability
- [ ] **Controller-Based Refactor** — Extract route handlers from `server.js` into dedicated controllers (`controllers/authController.js`, `controllers/filmController.js`, etc.) following the existing `routes/` directory structure.
- [ ] **Service Layer** — Introduce a service abstraction between controllers and raw SQL to centralize business logic and improve testability.
- [ ] **Prepared Statements** — Migrate all dynamic `searchQuery` concatenations to fully parameterized queries for defense-in-depth SQL injection protection.

### Content Management
- [x] **Film Creation Endpoint** — `POST /addFilm` with multipart poster upload (client-side resizing to 200×285px and WebP conversion), server-side image processing via Sharp, metadata validation (rating 0-10, duration > 0), automatic `film_translations` insertion with duplicate language prevention, and `film_genres` junction table population.
- [x] **Film Editor** — `PUT /updateFilm/:id` for updating base metadata (rating, release date, duration), poster replacement with Sharp processing, complete translation management (add/edit/remove), and genre reassignment. Implements SQL transactions for atomicity and rollback on failure.
- [x] **Film Detail Endpoints** — `GET /getFilmTranslations/:id`, `GET /getFilmGenres/:id`, and `GET /getAllGenresList` for fetching all translations, assigned genres, and available genres for the admin film editor interface.

### Analytics & Dashboard
- [x] **Dashboard Overview** — `GET /api/admin/dashboard/overview` providing aggregate metrics: total films, total users, active users count.
- [x] **Film Analytics Endpoint** — `GET /api/admin/dashboard/films-analytics` delivering: top 10 most popular films (by likes/watched), average rating with min/max range, recent additions (last week/month/year), genre distribution data for pie chart visualization.
- [x] **User Analytics Endpoint** — `GET /api/admin/dashboard/users-analytics` providing: moderation statistics (banned/suspended counts), 7-day user registration trend for time-series charts.
- [x] **Audit Logs Endpoint** — `GET /api/admin/dashboard/audit-logs` with server-side pagination (50 records/page), tracking user actions on films (like/unlike/watched/unwatched) with timestamps and user attribution.

### Observability & Audit
- [ ] **Enhanced `user_activity` Table** — Extend audit log to capture admin actions: bans, suspensions, promotions, and failed login attempts with IP attribution.
- [ ] **Activity Stream Filtering** — Advanced query parameters for filtering audit logs by actor type, action category, date range, and specific users.
- [ ] **Failed Auth Tracking** — Schema extension to store IP, timestamp, and targeted account for brute-force analysis.

### Security & Performance
- [x] **Rate Limiting** — `express-rate-limit` active: 750 req/15min global, 10 req/15min auth endpoints
- [x] **Helmet.js** — HTTP security headers active (CSP, HSTS, X-Frame-Options)
- [ ] **Input Sanitization** — `express-validator` schemas for all POST bodies.
- [x] **Connection Pooling** — MySQL connection pool implemented in database.js

---

## 🚀 Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/) (LTS recommended)
- [MySQL](https://www.mysql.com/) server instance
- [Resend](https://resend.com/) API key (free tier: 100 emails/day, 3000/month) with verified domain

### Installation

```bash
# Clone the repository
git clone https://github.com/Dziopino/Movies-Backend.git
cd Movies-Backend

# Install dependencies
npm install

# Configure environment
cp .env.example .env
# Edit .env with your database and Resend API key (see below)

# Setup Resend domain (production only)
# 1. Add your domain at https://resend.com/domains
# 2. Configure DNS records (DKIM, SPF CNAME, DMARC) at your registrar
# 3. Wait for verification (~10-60 minutes)

# Start the server
npm start
```

The API will listen on the port defined in `process.env.PORT` (default: `8000`).

## 🛢 Database setup
1. Create a MySQL database.
2. Import database/cinemix.sql.
3. Configure database credentials in .env.
4. Start the backend with npm run dev.

---

## 🔐 Environment Variables

Create a `.env` file in the project root:

```env
PORT=8000
NODE_ENV=development

# Database
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=cinemix
DB_PORT=3306

# Security
JWT_SECRET=your_64_byte_hex_secret
JWT_EXPIRES_IN=7d

# Email (Resend API)
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxxxxx

# Cloudinary (Image Storage)
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# CORS & Frontend
FRONTEND_URL=http://localhost:5173
CORS_ORIGIN=http://localhost:5173
```

### Email Configuration Notes

**Local Development:**
- Resend sandbox mode allows sending to your registered email only
- Perfect for testing password reset flows

**Production Deployment:**
- Add and verify your custom domain at [resend.com/domains](https://resend.com/domains)
- Configure DNS records at your registrar:
    - `resend._domainkey` TXT (DKIM signature)
    - `rsend` CNAME → `rsend-euw1.forge.rmta.net` (SPF)
    - `send` CNAME → `send.forge.rmta.net` (SPF)
    - `_dmarc` TXT → `v=DMARC1; p=none;`
- Update `from` address in code to use your domain (e.g., `noreply@yourdomain.com`)
- Resend free tier: 100 emails/day, 3000/month

**Why Resend instead of SMTP?**
Cloud platforms (Render, Vercel, Heroku) block outbound SMTP ports (25/587/465) to prevent spam abuse. Resend uses HTTPS API (port 443) which is never blocked, providing reliable email delivery in serverless/container environments.

> **Important:** Never commit `.env` to version control. The repository's `.gitignore` excludes it by default.

---

## 👤 Author

**Filip Dziopa**

- ⚙️ Backend: [github.com/Dziopino/Movies-Backend](https://github.com/Dziopino/Movies-Backend)
- 🌐 Frontend: [github.com/Dziopino/Movies-Frontend](https://github.com/Dziopino/Movies-Frontend)

---

---

*Copyright © 2026 **Filip Dziopa**. All rights reserved.*

This project is part of my personal development portfolio. The source code is publicly accessible for review and evaluation purposes by recruiters and technical interviewers only. No part of this repository may be duplicated, modified, or redistributed without explicit written permission from the author.

---

<div align="center">

**[⬆ Back to Top](#-cinemix--backend-api)**

Engineered for reliability. Architected for growth.

</div>
