const express = require('express');
const cors = require('cors');
const mysql = require('mysql');
const app = express();
const bcrypt = require('bcrypt');
const multer = require("multer");
const path = require("path");
const fs = require("fs").promises;
const sharp = require("sharp");
const crypto = require("crypto");
const nodemailer = require("nodemailer");
const connection = require("./database");
const isPasswordValid = require("./utils/passwordValidator");
const hashPassword = require("./utils/passwordHasher");
const generateToken = require("./utils/generateToken");
const authMiddleware = require("./middleware/authMiddleware");
const optionalAuthMiddleware = require("./middleware/optionalAuthMiddleware");
const adminMiddleware = require("./middleware/adminMiddleware");
const {loadLanguages, isLanguageValid} = require("./utils/languageValidator");
const checkIfUserIsAdmin = require("./utils/checkIfUserIsAdmin");
require('dotenv').config();
app.use(express.json());
app.use(cors());


const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: process.env.MAIL_USER,
        pass: process.env.MAIL_PASSWORD
    }
});

connection.connect((err) => {
    if (err) {
        console.log("Error connecting to database. Error: "+err);
    }else{
        console.log("Connected to database");
        loadLanguages(connection);
    }
})

const upload = multer({
    storage: multer.memoryStorage(),
    limits: {
        fileSize: 2 * 1024 * 1024
    },
    fileFilter: (req, file, cb) => {

        if (!file.mimetype.startsWith("image/")) {
            return cb(new Error("Only images are allowed"));
        }

        cb(null, true);
    }
});



app.post('/checkLoginData', (req, res) => {
    const {email, password} = req.body;
    if (!email || !password) {
       return res.json({message: "Invalid email or password"});
    }
    connection.query("SELECT users.id, users.password, users.username, users.avatar_url, users.email, users.created_at, users.role, users.bio, users.language_code, users.status, users.suspended_until FROM users WHERE users.email = ?", [email],(err, users) => {
        if (err) {
           return res.json({message: "Database error", success: false});
        }else if(users.length === 0) {
           return res.json({message: "Invalid email or password", success: false});
        }else if(users.length === 1) {
            bcrypt.compare(password, users[0].password, (err, result) => {
                if (err) {
                   return res.json({message: "Hashing password failed", success: false});
                }

                if(result === false) {
                   return res.json({message: "Invalid email or password", success: false});
                }

                if(users[0].status === "BANNED") {
                    return res.json({message: "Account banned", success: false, banned:true});
                }

                if(users[0].status === "SUSPENDED") {
                    if (new Date(users[0].suspended_until) > new Date()) {
                        return res.json({message: "Account suspended", success: false, suspended: true, suspendedUntil: users[0].suspended_until});
                    }else{
                        connection.query("UPDATE users SET status='ACTIVE', suspended_until=NULL WHERE id=?", [users[0].id]);
                        users[0].status = "ACTIVE";
                        users[0].suspended_until = null;
                    }
                }

                    const token = generateToken(users[0]);

                    delete users[0].password;

                    return res.json({message: "Logged in successfully", token, user: users[0], success: true});


            })
        }
    })
})

app.post('/addUser', async (req, res) => {
    const {username, email, password} = req.body;

    if (!username || !email || !password) {
        return res.json({message: "Invalid input data",success:false});
    }

    if (!isPasswordValid(password)) {
        return res.status(400).json({message:"Password requirements not met", success:false});
    }

    try {

        const hash = await hashPassword(password);

        connection.query("INSERT INTO `users`(`password`, `username`, `email`) VALUES (?,?,?)", [hash, username, email], (err, result) => {

                if (err) {
                    if (err.code === "ER_DUP_ENTRY") {
                        return res.json({message:"Email already exists",success:false});
                    }

                    return res.json({message:"Error while registering",success:false});
                }

                const insertedId = result.insertId;

                connection.query("SELECT users.id, users.password, users.username, users.avatar_url, users.email, users.created_at, users.role, users.bio, users.language_code FROM users WHERE users.id = ?", [insertedId], (err, user) => {

                    if (err) {
                        return res.json({message: "Error while registering"});
                    }

                    const token = generateToken(user[0]);

                    delete user[0].password;

                    res.json({message:"Registered successfully", token, user:user[0],success:true});
                });
            }
        );

    } catch (err) {
        return res.json({message: "Password hashing error"});
    }
})

app.post('/getFilms', optionalAuthMiddleware, (req, res) => {

    const userId = req.user?.id || null;
    let language = req.body.language || "en";
    const page = Number(req.body.page) || 1;
    const limit = 20;
    const offset = (page - 1) * limit;
    const search = req.body.search || "";

    let searchQuery = "";

    if(search){
        searchQuery = "AND film_translations.title LIKE ?";
    }

    if (!isLanguageValid(language)) {
        language = "en";
    }


    connection.query(`SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration,film_translations.title, film_translations.description, user_favorites.film_id, user_watched.film_id AS watchedFilmId FROM films INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_favorites ON films.id = user_favorites.film_id AND user_favorites.user_id = ? LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = ? WHERE film_translations.language_code = ? ${searchQuery} ORDER BY films.id DESC LIMIT ? OFFSET ?`, search ? [userId, userId, language, `%${search}%`, limit, offset] : [userId, userId, language, limit, offset], (err,result)=>{

            if(err){
                console.log(err);
                return res.json({message:"Error getting films"});
            }

            connection.query(`SELECT COUNT(*) AS count FROM films INNER JOIN film_translations ON films.id = film_translations.film_id WHERE film_translations.language_code = ? ${searchQuery}`,  search  ? [language, `%${search}%`]  : [language],  (err,count)=>{

                    if(err){
                        console.log(err);
                        return res.json({message:"Error counting films"});
                    }

                    return res.json({message:"Films got successfully", body:result, totalPages:Math.ceil(count[0].count / limit)});

                }
            );
        }
    );
});

app.post("/likeToggle",authMiddleware, (req, res) => {
    const {filmId} = req.body;
    const userId = req.user.id;

    if (!filmId){
        return res.json({message: "Something went wrong!"});
    }
    connection.query("SELECT user_favorites.user_id,user_favorites.film_id FROM users INNER JOIN user_favorites ON users.id = user_favorites.user_id INNER JOIN films ON user_favorites.film_id = films.id WHERE films.id = ? AND users.id = ?",[filmId,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while checking is film already favorite. Error: "+err});
        }
        if (result.length === 0 ){
            connection.query("INSERT INTO `user_favorites`(`user_id`, `film_id`) VALUES (?,?)",[userId,filmId],(err, result) => {
                if (err) {
                    return res.json({message: "Error inserting user_favorites. Error: "+err});
                }
                if (result){
                    return res.json({message:"Added successfully",body:result});
                }
            })
        }else if(result.length === 1){
            connection.query("DELETE FROM `user_favorites` WHERE `user_favorites`.`user_id` = ? AND `user_favorites`.`film_id` = ?",[userId,filmId],(err, result) => {
                if (err) {
                    return res.json({message: "Error deleting user_favorites. Error: "+err});
                }
                if (result){
                    return res.json({message:"Deleted successfully",body:result});
                }
            })
        }
    })
})

app.post("/watchedToggle",authMiddleware, (req, res) => {
    const {filmId} = req.body;
    const userId = req.user.id;

    if (!filmId){
        return res.json({message: "Something went wrong!"});
    }
    connection.query("SELECT user_watched.user_id FROM users INNER JOIN user_watched ON users.id = user_watched.user_id INNER JOIN films ON user_watched.film_id = films.id WHERE films.id = ? AND users.id = ?",[filmId,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while checking is film already watched. Error: "+err});
        }
        if (result.length === 0 ){
            connection.query("INSERT INTO `user_watched`(`user_id`, `film_id`) VALUES (?,?)",[userId,filmId],(err, result) => {
                if (err) {
                    return res.json({message: "Error inserting user_watched. Error: "+err});
                }
                if (result){
                    return res.json({message:"Added successfully",body:result});
                }
            })
        }else if(result.length === 1){
            connection.query("DELETE FROM `user_watched` WHERE `user_watched`.`user_id` = ? AND `user_watched`.`film_id` = ?",[userId,filmId],(err, result) => {
                if (err) {
                    return res.json({message: "Error deleting user_watched. Error: "+err});
                }
                if (result){
                    return res.json({message:"Deleted successfully",body:result});
                }
            })
        }
    })
})
app.post("/likedGet", authMiddleware, (req, res) => {

    const userId = req.user.id;
    const page = Number(req.body.page) || 1;
    const limit = 20;
    const offset = (page - 1) * limit;
    const search = req.body.search || "";
    let searchQuery = "";

    if(search){
        searchQuery = "AND film_translations.title LIKE ?";
    }

    connection.query(`SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration,film_translations.title, film_translations.description, user_favorites.film_id, user_watched.film_id AS watchedFilmId FROM user_favorites INNER JOIN films  ON user_favorites.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = user_favorites.user_id WHERE user_favorites.user_id = ? AND film_translations.language_code = ( SELECT language_code FROM users  WHERE id = ?) ${searchQuery} ORDER BY user_favorites.created_at DESC LIMIT ? OFFSET ?`, search ? [userId, userId, `%${search}%`, limit, offset] : [userId, userId, limit, offset], (err,result)=>{

            if(err){
                console.log(err);
                return res.json({message:"Error while getting favorites",success:false});
            }

            connection.query(`SELECT COUNT(*) AS count FROM user_favorites INNER JOIN films ON user_favorites.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id WHERE user_favorites.user_id = ? AND film_translations.language_code = ( SELECT language_code  FROM users  WHERE id = ?) ${searchQuery}`, search  ?  [userId, userId, `%${search}%`]  :  [userId, userId], (err,count)=>{

                    if(err){
                        console.log(err);
                        return res.json({message:"Error counting favorites", success:false});
                    }
                    return res.json({message:"Liked got successfully", body:result, totalPages:Math.ceil(count[0].count / limit), success:true});
                });
        });
});

app.post("/watchedGet",authMiddleware, (req, res) => {
    const userId = req.user.id;
    const page = Number(req.body.page) || 1;
    const limit = 20;
    const offset = (page - 1) * limit;
    const search = req.body.search || "";
    let searchQuery = "";

    if(search){
        searchQuery = "AND film_translations.title LIKE ?";
    }

    connection.query(`SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration,film_translations.title, film_translations.description, user_favorites.film_id, user_watched.film_id AS watchedFilmId FROM user_favorites INNER JOIN films  ON user_favorites.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = user_favorites.user_id WHERE user_watched.user_id = ? AND film_translations.language_code = ( SELECT language_code FROM users  WHERE id = ?) ${searchQuery} ORDER BY user_favorites.created_at DESC LIMIT ? OFFSET ?`, search ? [userId, userId, `%${search}%`, limit, offset] : [userId, userId, limit, offset], (err,result)=>{

        if(err){
            console.log(err);
            return res.json({message:"Error while getting watched", success:false});
        }

        connection.query(`SELECT COUNT(*) AS count FROM user_watched INNER JOIN films ON user_watched.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id WHERE user_watched.user_id = ? AND film_translations.language_code = ( SELECT language_code  FROM users  WHERE id = ?) ${searchQuery}`, search  ?  [userId, userId, `%${search}%`]  :  [userId, userId], (err,count)=>{

            if(err){
                console.log(err);
                return res.json({message:"Error counting watched", success:false});
            }
            return res.json({message:"Watched got successfully", body:result, totalPages:Math.ceil(count[0].count / limit), success:true});
        });
    });
})

app.post("/getUserData", authMiddleware, (req, res) => {
    const userId = req.user.id;

    connection.query("SELECT `username`, `avatar_url`, `email`, `created_at`, `role`, `bio`, `language_code` FROM users WHERE users.id = ?",[userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while getting user data"});
        }
        if (result){
            return res.json({message:"User data got successfully",body:result[0]});
        }
    })
})

app.get("/getLanguageCodes", (req, res) => {

    connection.query("SELECT `code`, `name` FROM `languages`",(err, result) => {
        if (err) {
            return res.json({message: "Error while getting languages list"});
        }
        if (result){
            return res.json({message:"Language codes got successfully ",body:result});
        }
    })
})

app.post("/editUserBio", authMiddleware, (req, res) => {
    const userId = req.user.id;
    const {userBio} = req.body;

    connection.query("UPDATE users SET users.bio=? WHERE users.id = ?",[userBio,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while updating user's bio"});
        }
        if (result){
            return res.json({message:"User's bio updated successfully"});
        }
    })
})

app.post("/changeUserLanguage", authMiddleware, (req, res) => {
    const userId = req.user.id;
    const {userLanguageCode} = req.body;


    if (!userLanguageCode) {
        return res.json({message: "Language code is missing"});
    }

    if (!isLanguageValid(userLanguageCode)) {
        return res.json({message: "This language is not available"});
    }

    connection.query("UPDATE `users` SET `language_code`= ? WHERE users.id = ?",[userLanguageCode,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while updating user's language"});
        }
        if (result){
            return res.json({message:"User's language changed successfully"});
        }
    })
})

app.post("/editUserName", authMiddleware, (req, res) => {
    const userId = req.user.id;
    const {userName} = req.body;

    if (!userName) {
        return res.json({message: "New user name is empty"});
    }

    connection.query("UPDATE `users` SET `username`= ? WHERE users.id = ?",[userName,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while updating username"});
        }
        if (result){
            return res.json({message:"Username changed successfully",body:result});
        }
    })
})

app.use((err, req, res, next) => {
    if (err instanceof multer.MulterError) {
        return res.json({ message: "File too large (max 2MB)" });
    }

    if (err) {
        return res.json({ message: err.message });
    }

    next();
});

app.post("/uploadAvatar", authMiddleware, upload.single("avatar"), async (req, res) => {

    const userId = req.user.id;

    if (!req.file) {
        return res.json({ message: "No file uploaded" });
    }



    const fileName = crypto.randomBytes(16).toString("hex") + ".webp";
    const outputPath = path.join(__dirname, "uploads", fileName);

    try {

        await sharp(req.file.buffer)
            .resize(300, 300, { fit: "cover" })
            .webp({ quality: 80 })
            .toFile(outputPath);


        const newAvatarUrl = "/uploads/" + fileName;


        connection.query("SELECT avatar_url FROM users WHERE id = ?", [userId], async (err, result) => {

                if (err) {
                    return res.json({message:"Database error"});
                }

                const oldAvatar = result[0]?.avatar_url;

                if(oldAvatar && oldAvatar.startsWith("/uploads/")) {

                    const oldPath = path.join(
                        __dirname,
                        oldAvatar
                    );

                    try {
                        await fs.unlink(oldPath);
                    }
                    catch(err) {
                        if (err.code !== "ENOENT") {
                            console.error("Error deleting old avatar:", err);
                        }
                    }
                }


                connection.query("UPDATE users SET avatar_url=? WHERE id=?", [newAvatarUrl, userId], (err2)=>{

                        if(err2){
                            return res.json({message:"DB update error"});
                        }

                        res.json({message:"Avatar updated successfully", avatar_url:newAvatarUrl});
                    }
                );

            }
        );
    } catch(err){

        console.log(err);

        res.json({message:"Image processing failed", error:err.message});
    }

});
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

app.get("/getFilm/:id", optionalAuthMiddleware, (req, res) => {

    const filmId = req.params.id;
    let languageCode = req.query.language || "en";
    const userId = req.user?.id || null;

    if (!isLanguageValid(languageCode)) {
        languageCode = "en";
    }

    if (!filmId) {
        return res.json({ message: "Error id is missing" });
    }

    connection.query("SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, GROUP_CONCAT(DISTINCT genres.name ORDER BY genres.name SEPARATOR ', ') AS genres, uf.film_id AS favoriteFilmId, uw.film_id AS watchedFilmId FROM films INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN film_genres ON films.id = film_genres.film_id LEFT JOIN genres ON genres.id = film_genres.genre_id LEFT JOIN user_favorites uf ON uf.film_id = films.id AND uf.user_id = ? LEFT JOIN user_watched uw ON uw.film_id = films.id AND uw.user_id = ? WHERE films.id = ? AND film_translations.language_code = ? GROUP BY films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, uf.film_id, uw.film_id;", [userId,userId,filmId,languageCode], (err, result) => {
            if (err) {
                return res.json({ message: "Error while getting film" });
            }

            return res.json({ body: result[0] });
        }
    );
});

app.post("/requestPasswordReset", (req, res) => {
    const {email} = req.body;

    connection.query("SELECT id FROM users WHERE email = ?", [email], (err, result) => {
        if (err) {
            return res.status(500).json({message:"Database error"});
        }

        if (result.length === 0) {
            return res.json({message:"If this email exists, a reset link has been sent."});
        }

        const id = result[0].id;
        const token = crypto.randomBytes(32).toString("hex");
        const expiry = new Date(Date.now() + 1000*60*15);

        connection.query("UPDATE users SET reset_token=?, reset_token_expiry=? WHERE id=?", [token, expiry, id], (err) => {
            if (err) {
                return res.status(500).json({message:"Database error"});
            }

            transporter.sendMail({
                from: `"MovieApp Support" <${process.env.EMAIL_USER}>`,
                to: email,
                subject: "Password reset",
                html: `
                    <h2>Password reset</h2>
                    <p>You requested a password reset.</p>
                    <a href="http://localhost:5173/resetPassword/${token}">
                        Reset password
                    </a>
                    <p>This link expires in 15 minutes.</p>
                `
            });

            return res.json({message:"If this email exists, a reset link has been sent."});
        });
    });
});

app.get("/getResetToken/:token", (req, res) => {
    const token = req.params.token;

    if (!token) {
        return res.json({message:"No token found"});
    }

    connection.query("SELECT reset_token_expiry FROM users WHERE reset_token = ?", [token], (err, result) => {
        if (err) {
            return res.status(500).json();
        }

        if (result.length === 0) {
            return res.json({valid:false});
        }

        const expiry = new Date(result[0].reset_token_expiry);

        if (Date.now() > expiry.getTime()) {
            return res.json({valid:false});
        }

        return res.json({ valid:true});
    });
});

app.post("/resetPassword/:token", async (req,res) => {

    const token = req.params.token;
    const {password} = req.body;


    if (!isPasswordValid(password)) {
        return res.status(400).json({
            message:"Password does not meet requirements"
        });
    }

    connection.query("SELECT id, reset_token_expiry FROM users WHERE reset_token = ?", [token], async (err, result) => {

            if (err) {
                return res.status(500).json({message:"Database error" , isChanged: false});
            }

            if (result.length === 0) {
                return res.json({message:"✗ Invalid token" , isChanged: false});
            }

            const expiry = new Date(result[0].reset_token_expiry);

            if (Date.now() > expiry.getTime()) {
                return res.json({message:"✗ Token expired" , isChanged: false});
            }

            try {
                const hashedPassword = await hashPassword(password);

                connection.query("UPDATE users SET password=?, reset_token=NULL, reset_token_expiry=NULL WHERE id=?", [hashedPassword, result[0].id], (err, result) => {

                        if (err) {
                            return res.status(500).json({
                                message:"✗ Database error", isChanged: false
                            });
                        }

                        return res.json({
                            message:"✓ Password changed successfully", isChanged: true
                        });
                    }
                );

            } catch(err) {
                return res.status(500).json({
                    message:"Password hashing error"
                });
            }
        }
    );
});

app.get("/getUsers", authMiddleware, adminMiddleware, (req, res) => {

    const page = Number(req.query.page) || 1;
    const limit = 25;
    const offset = (page - 1) * limit;
    const search = req.query.search || "";

    let searchQuery = "";

    if (search) {
        searchQuery = "WHERE users.id LIKE ? OR users.username LIKE ? OR users.email LIKE ?";
    }


    connection.query(`SELECT id, username, avatar_url, email, created_at, role, status, language_code, languages.name AS language FROM users LEFT JOIN languages ON languages.code = users.language_code ${searchQuery} ORDER BY users.id DESC LIMIT ? OFFSET ?`, search ? [search,`%${search}%`, `%${search}%`, limit, offset] : [limit, offset], (err, result) => {

            if(err){
                return res.json({success:false, message:"database_error"});
            }


        connection.query(`SELECT COUNT(id) AS count FROM users ${searchQuery}`, search ? [search,`%${search}%`, `%${search}%`] : [], (err, countResult) => {

                    if(err){
                        return res.json({success:false, message:"database_error"});
                    }
                    const users_count = countResult[0].count;
                    const totalPages = Math.ceil(users_count / limit);

                    return res.json({success:true, users:result, totalPages, users_count});
                }
            );
        }
    );
});

app.get("/refreshUser/:userId", authMiddleware, adminMiddleware, (req, res) => {
    const userId = req.params.userId;
    if (!userId) {
        return res.json({message:"no_user_found", success: false});
    }
    connection.query("SELECT `id`, `username`, `avatar_url`, `email`, `created_at`, `role`, `status`,`language_code`, languages.name AS \"language\" FROM `users` LEFT JOIN languages ON users.language_code = languages.code WHERE users.id = ?",[userId],(err, result) => {
        if (err){
            return res.status(500).json({message:"database_error",success:false});
        }
        if(result.length === 0){
            return res.json({success:false, message:"user_not_found"});
        }

        return res.json({message: "user_fetched_successfully", user: result[0], success: true});

    })
})

app.post("/banUser", authMiddleware, adminMiddleware, (req,res) => {
    const {userId,userStatus,banReason} = req.body;

    const banBy = req.user.id;

    if (!userId) {
        return res.json({message:"no_user_found", success: false});
    }

    if (!banReason) {
        return res.json({message:"enter_ban_reason", success: false});
    }

    if(userStatus === "BANNED"){
        return res.json({message:"user_is_already_banned", success: false});
    }

    checkIfUserIsAdmin(connection, userId, (err, isAdmin, notFound)=> {

        if (err) {
            return res.status(500).json({success: false, message: "database_error"});
        }

        if (notFound) {
            return res.json({success: false, message: "user_not_found"});
        }

        if (isAdmin) {
            return res.json({success: false, message: "you_cannot_ban_another_admin"});
        }

        connection.query(`UPDATE users SET status = "BANNED", suspended_until = NULL,suspend_reason = NULL, suspended_at = NULL,suspended_by = NULL, ban_reason = ?, banned_at = NOW(), banned_by = ? WHERE id = ?`,[banReason,banBy,userId],(err, result) => {
            if (err){
                return res.status(500).json({message:"database_error",success:false});
            }
            if(result.affectedRows === 0){
                return res.json({success:false, message:"user_not_found"});
            }

            return res.json({message: "user_banned_successfully", success: true});

        })
    })
})

app.post("/suspendUser", authMiddleware, adminMiddleware, (req,res) => {
    const {userId,userStatus,suspendReason,suspendUntil} = req.body;

    const suspendBy = req.user.id;


    if (!suspendReason) {
        return res.json({message:"enter_suspend_reason", success: false});
    }

    if (!suspendUntil) {
        return res.json({message:"enter_date_until_user_will_be_suspended", success: false});
    }

    if (!userId) {
        return res.json({message:"no_user_found", success: false});
    }

    if(userStatus === "SUSPENDED"){
        return res.json({message:"user_is_already_suspended", success: false});
    }

    if (new Date(suspendUntil) <= new Date()) {
        return res.json({success: false, message: "suspend_date_must_be_in_the_future"});
    }

    checkIfUserIsAdmin(connection, userId, (err, isAdmin, notFound)=> {

        if (err) {
            return res.status(500).json({success: false, message: "database_error"});
        }

        if (notFound) {
            return res.json({success: false, message: "user_not_found"});
        }

        if (isAdmin) {
            return res.json({success: false, message: "you_cannot_suspend_another_admin"});
        }

        connection.query(`UPDATE users SET status = "SUSPENDED", suspended_until = ? ,suspend_reason = ?, suspended_at = NOW(),suspended_by = ?, ban_reason = NULL, banned_at = NULL, banned_by = NULL WHERE id = ?`,[suspendUntil, suspendReason, suspendBy, userId],(err,result) => {
            if (err){
                return res.status(500).json({message:"database_error",success:false});
            }
            if(result.affectedRows === 0){
                return res.json({success:false, message:"user_not_found"});
            }

            return res.json({message: "user_suspended_successfully", success: true});

        })
    })
})

app.post("/unBanUser", authMiddleware, adminMiddleware, (req,res) => {
    const {userId,userStatus} = req.body;

    if (!userId) {
        return res.json({message:"no_user_found", success: false});
    }

    if(userStatus !== "BANNED"){
        return res.json({message:"user_is_not_banned", success: false});
    }

    connection.query(`UPDATE users SET status = "ACTIVE", ban_reason = NULL, banned_at = NULL, banned_by = NULL WHERE id = ?`,[userId],(err,result) => {
        if (err){
            return res.status(500).json({message:"database_error",success:false});
        }
        if(result.affectedRows === 0){
            return res.json({success:false, message:"user_not_found"});
        }

        return res.json({message: "user_unbanned_successfully", success: true});

    })
})

app.post("/unSuspendUser", authMiddleware, adminMiddleware, (req,res) => {
    const {userId,userStatus} = req.body;

    if (!userId) {
        return res.json({message:"no_user_found", success: false});
    }

    if(userStatus !== "SUSPENDED"){
        return res.json({message:"user_is_not_suspended", success: false});
    }

    connection.query(`UPDATE users SET status = "ACTIVE", suspended_until = NULL, suspend_reason = NULL, suspended_at = NULL, suspended_by = NULL WHERE id = ?`,[userId],(err, result) => {
        if (err){
            return res.status(500).json({message:"database_error",success:false});
        }
        if(result.affectedRows === 0){
            return res.json({success:false, message:"user_not_found"});
        }

        return res.json({message: "user_unsuspended_successfully", success: true});

    })
})

app.post("/promoteUser", authMiddleware, adminMiddleware, (req,res)=>{

    const {userId,password} = req.body;

    if (!userId) {
        return res.json({message:"no_user_found", success: false});
    }

    if (!password) {
        return res.json({message:"no_password_found", success: false});
    }

    const adminId = req.user.id;

    connection.query("SELECT password FROM users WHERE id=?", [adminId], (err,result)=>{

            if(err){
                return res.status(500).json({success:false,message:"database_error"});
            }

            bcrypt.compare(password,result[0].password,(err,match)=>{

                if(!match){
                    return res.json({success:false, message:"invalid_password"});
                }

                connection.query("UPDATE users SET role=1 WHERE id=?", [userId], (err,result)=>{

                        if(err){
                            return res.status(500).json({success:false, message:"database_error"});
                        }
                        if(result.affectedRows === 0){
                            return res.json({success:false, message:"user_not_found"});
                        }

                        return res.json({success:true, message:"user_promoted_to_admin"});

                    }
                );
            });
        }
    );
});

app.post("/checkSuspensions", authMiddleware, adminMiddleware, (req,res)=>{
    connection.query(`UPDATE users SET status='ACTIVE', suspended_until=NULL WHERE status='SUSPENDED' AND suspended_until <= NOW()`, (err,result)=>{
            if(err){
                console.log(err);
                return res.json({message:"error_checking_suspensions",success:false});
            }
            return res.json({message:"suspensions_checked_successfully", updated:result.affectedRows, success:true});
        }
    );
});

app.get("/getGenres", authMiddleware, adminMiddleware, (req, res) => {

    const page = Number(req.query.page) || 1;
    const limit = 20;
    const offset = (page - 1) * limit;
    const search = req.query.search || "";

    let searchQuery = "";

    if (search) {
        searchQuery = "WHERE genres.id LIKE ? OR genres.name LIKE ?";
    }


    connection.query(`SELECT genres.id, genres.name, COUNT(film_genres.film_id) AS movies_count FROM genres LEFT JOIN film_genres ON genres.id = film_genres.genre_id ${searchQuery} GROUP BY genres.id, genres.name ORDER BY genres.id DESC LIMIT ? OFFSET ?`, search ? [search, `%${search}%`, limit, offset] : [limit, offset], (err, result) => {

            if(err){
                return res.json({success:false, message:"database_error"});
            }


            connection.query(`SELECT COUNT(id) AS count FROM genres ${searchQuery}`, search ? [search,`%${search}%`] : [], (err, countResult) => {

                    if(err){
                        return res.json({success:false, message:"database_error"});
                    }
                    const genres_count = countResult[0].count;
                    const totalPages = Math.ceil(genres_count / limit);

                    return res.json({success:true, genres:result, totalPages, genres_count});
                }
            );
        }
    );
});

app.get("/refreshGenre/:genreId", authMiddleware, adminMiddleware, (req, res) => {
    const genreId = req.params.genreId;
    if (!genreId) {
        return res.json({message:"no_genre_found", success: false});
    }
    connection.query("SELECT genres.id, genres.name, COUNT(film_genres.film_id) AS movies_count FROM genres LEFT JOIN film_genres ON genres.id = film_genres.genre_id WHERE genres.id = ? GROUP BY genres.id, genres.name ORDER BY genres.id",[genreId],(err, result) => {
        if (err){
            return res.status(500).json({message:"database_error",success:false});
        }
        if(result.length === 0){
            return res.json({success:false, message:"genre_not_found"});
        }

        return res.json({message: "genre_fetched_successfully", genre: result[0], success: true});

    })
})

app.post("/deleteGenre", authMiddleware, adminMiddleware, (req,res)=>{

    const {genreId,password} = req.body;

    if (!genreId) {
        return res.json({message:"no_genre_found", success: false});
    }

    if (!password) {
        return res.json({message:"no_password_found", success: false});
    }

    const adminId = req.user.id;

    connection.query("SELECT password FROM users WHERE id=?", [adminId], (err,result)=>{

            if(err){
                return res.status(500).json({success:false,message:"database_error"});
            }

            bcrypt.compare(password,result[0].password,(err,match)=>{

                if(!match){
                    return res.json({success:false, message:"invalid_password"});
                }

                connection.query("DELETE FROM genres WHERE id = ?;", [genreId], (err,result)=>{

                        if(err){
                            return res.status(500).json({success:false, message:"database_error"});
                        }
                        if(result.affectedRows === 0){
                            return res.json({success:false, message:"genre_not_found"});
                        }

                        return res.json({success:true, message:"genre_deleted_successfully"});
                    }
                );
            });
        }
    );
});

app.post("/editGenre", authMiddleware, adminMiddleware, (req,res) => {
    const genreId = req.body.genreId;
    let newGenreName = req.body.newGenreName;

    newGenreName = newGenreName.trim().toLowerCase();

    if (!genreId) {
        return res.json({message:"no_genre_found", success: false});
    }

    if(!newGenreName){
        return res.json({message:"no_new_genre_name_found", success: false});
    }

    connection.query(`UPDATE genres SET genres.name = ? WHERE id = ?`,[newGenreName, genreId],(err, result) => {
        if (err) {
            if (err.code === "ER_DUP_ENTRY") {
                return res.json({success: false, message: "genre_already_exists"});
            }

            return res.status(500).json({success: false, message: "database_error"});
        }
        if(result.affectedRows === 0){
            return res.json({success:false, message:"genre_not_found"});
        }

        return res.json({message: "genre_edited_successfully", success: true});

    })
})

app.post("/addGenre", authMiddleware, adminMiddleware, (req,res) => {
    let newGenreName = req.body.newGenreName;

    newGenreName = newGenreName.trim().toLowerCase();

    if(!newGenreName){
        return res.json({message:"no_new_genre_name_found", success: false});
    }

    connection.query(`INSERT INTO genres (genres.name) VALUES (?)`,[newGenreName],(err, result) => {
        if (err) {
            if (err.code === "ER_DUP_ENTRY") {
                return res.json({success: false, message: "genre_already_exists"});
            }

            return res.status(500).json({success: false, message: "database_error"});
        }

        return res.json({message: "genre_added_successfully", success: true});

    })
})

app.get("/getFilmsAdmin", authMiddleware, adminMiddleware, (req, res) => {

    const page = Number(req.query.page) || 1;
    const limit = 20;
    const offset = (page - 1) * limit;
    const search = req.query.search || "";
    const language = req.query.language || "en";
    let searchQuery = "";

    if(search){
        searchQuery = "WHERE films.id LIKE ? OR film_translations.title LIKE ?";
    }


    connection.query(`SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, COUNT(film_genres.genre_id) AS genres_count FROM films JOIN film_translations ON film_translations.film_id = films.id AND film_translations.language_code = ? LEFT JOIN film_genres ON film_genres.film_id = films.id  ${searchQuery} GROUP BY films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title ORDER BY films.id DESC LIMIT ? OFFSET ?`, search ? [language, search, `%${search}%`, limit, offset] : [language, limit, offset], (err,result)=>{

            if(err){
                return res.json({success:false, message:"database_error"});
            }


            connection.query(`SELECT COUNT(DISTINCT films.id) AS count FROM films JOIN film_translations ON film_translations.film_id = films.id AND film_translations.language_code = ?${searchQuery}`,  search ? [language, search, `%${search}%`] : [language], (err,countResult)=>{

                    if(err){
                        return res.json({success:false, message:"database_error"});
                    }

                    const films_count = countResult[0].count;
                    const totalPages = Math.ceil(films_count / limit);

                    return res.json({success:true, films:result, totalPages, films_count});

                });
        });
});

app.post("/deleteFilm", authMiddleware, adminMiddleware, (req,res)=>{

    const {filmId,password} = req.body;

    if (!filmId) {
        return res.json({message:"no_film_found", success: false});
    }

    if (!password) {
        return res.json({message:"no_password_found", success: false});
    }

    const adminId = req.user.id;

    connection.query("SELECT password FROM users WHERE id=?", [adminId], (err,result)=>{

            if(err){
                return res.status(500).json({success:false,message:"database_error"});
            }

            bcrypt.compare(password,result[0].password,(err,match)=>{

                if(!match){
                    return res.json({success:false, message:"invalid_password"});
                }

                connection.query("DELETE FROM films WHERE id = ?;", [filmId], (err,result)=>{

                        if(err){
                            return res.status(500).json({success:false, message:"database_error"});
                        }
                        if(result.affectedRows === 0){
                            return res.json({success:false, message:"film_not_found"});
                        }

                        return res.json({success:true, message:"film_deleted_successfully"});
                    }
                );
            });
        }
    );
});

app.post('/addAdmin',authMiddleware, adminMiddleware, async (req, res) => {
    const {username, email, password} = req.body;

    if (!username || !email || !password) {
        return res.json({message: "invalid_input_data",success:false});
    }

    if (!isPasswordValid(password)) {
        return res.status(400).json({message:"password_requirements_not_met", success:false});
    }

    try {

        const hash = await hashPassword(password);

        connection.query("INSERT INTO `users`(`password`, `username`, `email`, `role`) VALUES (?,?,?,1)", [hash, username, email], (err) => {

                if (err) {
                    if (err.code === "ER_DUP_ENTRY") {
                        return res.json({message:"email_already_exists",success:false});
                    }

                    return res.json({message:"error_while_registering",success:false});
                }

                return res.json({message:"admin_created_successfully",success:true})
            }
        );

    } catch (err) {
        return res.json({message: "password_hashing_error",success:false});
    }
})



if (require.main === module) {
    app.listen(process.env.PORT, () => {
        console.log(`Server started on port ${process.env.PORT}`);
    });
}

module.exports = app;

