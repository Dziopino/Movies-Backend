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
const isPasswordValid = require("./utils/passwordValidator");
const hashPassword = require("./utils/passwordHasher");
const generateToken = require("./utils/generateToken");
const authMiddleware = require("./middleware/authMiddleware");
const optionalAuthMiddleware = require("./middleware/optionalAuthMiddleware");
const adminMiddleware = require("./middleware/adminMiddleware");
const {loadLanguages, isLanguageValid} = require("./utils/languageValidator");
require('dotenv').config();
app.use(express.json());
app.use(cors());


const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
})

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
    connection.query("SELECT users.id, users.password, users.username, users.avatar_url, users.email, users.created_at, users.role, users.bio, users.language_code FROM users WHERE users.email = ?", [email],(err, users) => {
        if (err) {
           return res.json({message: "Error getting users. Error: "+err});
        }else if(users.length === 0) {
           return res.json({message: "Invalid email or password"});
        }else if(users.length === 1) {
            bcrypt.compare(password, users[0].password, (err, result) => {
                if (err) {
                   return res.json({message: "Error bcrypt. Error: "+err});
                }else if(result === false) {
                   return res.json({message: "Invalid email or password"});
                }else{

                    const token = generateToken(users[0]);

                    delete users[0].password;

                    return res.json({message: "Logged in successfully", token, user: users[0]});

                }
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
        return res.status(400).json({
            message:"Password does not meet requirements",
            success:false
        });
    }

    try {

        const hash = await hashPassword(password);

        connection.query(
            "INSERT INTO `users`(`password`, `username`, `email`) VALUES (?,?,?)", [hash, username, email], (err, result) => {

                if (err) {
                    if (err.code === "ER_DUP_ENTRY") {
                        return res.json({message:"Email already exists",success:false});
                    }

                    return res.json({message:"Error while registering",success:false});
                }

                const insertedId = result.insertId;

                connection.query("SELECT users.id, users.password, users.username, users.avatar_url, users.email, users.created_at, users.role, users.bio, users.language_code FROM users WHERE users.id = ?", [insertedId], (err, user) => {

                    if (err) {
                        return res.json({message: "Error while registering. Error: " + err,success:false});
                    }

                    const token = generateToken(user[0]);

                    delete user[0].password;

                    res.json({message:"Registered successfully", token, user:user[0],success:true});
                });
            }
        );

    } catch (err) {
        return res.json({
            message: "Password hashing error"
        });
    }
})

app.post('/getFilms', optionalAuthMiddleware, (req, res) => {

    const userId = req.user?.id || null;
    let language = req.body.language || "en";

    if (!isLanguageValid(language)) {
        language = "en";
    }

    connection.query(
        "SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, user_favorites.film_id, user_watched.film_id AS watchedFilmId FROM films INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_favorites ON films.id = user_favorites.film_id AND user_favorites.user_id = ? LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = ? WHERE film_translations.language_code = ?", [userId, userId, language], (err, result) => {

            if (err) {
                return res.json({message:"Error getting films. Error: "+err});
            }

            return res.json({message:"Films got successfully", body:result});
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
app.post("/likedGet",authMiddleware, (req, res) => {
    const userId = req.user.id

    connection.query("SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, user_watched.film_id AS watchedFilmId FROM user_favorites INNER JOIN films ON user_favorites.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = user_favorites.user_id WHERE user_favorites.user_id = ? AND film_translations.language_code = (SELECT language_code FROM users WHERE id = ?) ORDER BY user_favorites.created_at DESC",[userId,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while getting favorites. Error: "+err});
        }
        if (result){
            return res.json({message: "Liked got successfully" ,body:result});
        }
    })
})

app.post("/watchedGet",authMiddleware, (req, res) => {
    const userId = req.user.id;

    connection.query("SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, user_favorites.film_id AS userFavoritesFilms FROM user_watched INNER JOIN films ON user_watched.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_favorites ON films.id = user_favorites.film_id AND user_favorites.user_id = user_watched.user_id WHERE user_watched.user_id = ? AND film_translations.language_code = (SELECT language_code FROM users WHERE id = ? ) ORDER BY user_watched.watched_at DESC",[userId,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while getting watched. Error: "+err});
        }
        if (result){
            return res.json({message: "Watched got successfully" ,body:result});
        }
    })
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

    connection.query("SELECT films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, GROUP_CONCAT(DISTINCT genres.name ORDER BY genres.name SEPARATOR ', ') AS genres, uf.film_id AS favoriteFilmId, uw.film_id AS watchedFilmId FROM films INNER JOIN film_translations ON films.id = film_translations.film_id INNER JOIN film_genres ON films.id = film_genres.film_id INNER JOIN genres ON genres.id = film_genres.genre_id LEFT JOIN user_favorites uf ON uf.film_id = films.id AND uf.user_id = ? LEFT JOIN user_watched uw ON uw.film_id = films.id AND uw.user_id = ? WHERE films.id = ? AND film_translations.language_code = ? GROUP BY films.id, films.poster_url, films.rating, films.release_date, films.duration, film_translations.title, film_translations.description, uf.film_id, uw.film_id;", [userId,userId,filmId,languageCode], (err, result) => {
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

app.get("/getUsers",authMiddleware,adminMiddleware, (req, res) => {
    connection.query("SELECT `id`, `username`, `avatar_url`, `email`, `created_at`, `role`, `status`,`language_code`, languages.name AS \"language\" FROM `users` LEFT JOIN languages ON users.language_code = languages.code ORDER BY users.id",(err, result) => {
        if (err){
            return res.status(500).json({message:"Database error",success:false});
        }

        return res.json({message: "Users fetched successfully", users: result, success: true});

    })
})

app.get("/getUsersCount", authMiddleware, adminMiddleware, (req,res) => {
    connection.query("SELECT COUNT(id) AS users_count FROM users", (err,result) => {
            if(err){
                return res.status(500).json({message:"Database error", success:false});
            }

            return res.json({users_count: result[0].users_count,success:true});
        }
    );
});


app.listen(process.env.PORT, () => {
    console.log(`Server started on port ${process.env.PORT}`);
})

