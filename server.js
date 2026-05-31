const express = require('express');
const cors = require('cors');
const mysql = require('mysql');
const app = express();
const bcrypt = require('bcrypt');
const salt = 10;
require('dotenv').config();
app.use(express.json());
app.use(cors());

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
})

connection.connect((err) => {
    if (err) {
        console.log("Error connecting to database. Error: "+err);
    }else{
        console.log("Connected to database");
    }
})


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
                    delete users[0].password;
                   return res.json({
                       message: "Logged in successfully",
                       user: users[0]
                   });
                }
            })
        }
    })
})

app.post('/addUser', (req, res) => {
    const {username, email, password} = req.body;

    if (!username || !email || !password) {
        return res.json({message: "Invalid input data"});
    }

    bcrypt.hash(password,salt, (err, hash) => {
        if (err){
            return res.json({message: "Bcrypt error. Error: "+err});
        }
        connection.query("INSERT INTO `users`(`password`, `username`, `email`) VALUES (?,?,?)",[hash,username,email],(err, result) => {
            if (err) {
               return res.json({message: "Error while registering. Error: "+err});
            }
            const insertedId = result.insertId;
            connection.query("SELECT users.id, users.password, users.username, users.avatar_url, users.email, users.created_at, users.role, users.bio, users.language_code FROM users WHERE users.id = ?",[insertedId],(err,user) => {
                if (err) {
                    return res.json({message: "Error while registering. Error: "+err});
                }
                res.json({message:"Registered successfully",user:user[0]});
            })
        })
    })
})

app.post('/getFilms', (req, res) => {
    const {userId} = req.body;

    if (!userId) {
        return connection.query('SELECT films.id, films.poster_url, films.rating, films.relese_date, films.duration, film_translations.title, film_translations.description FROM films INNER JOIN film_translations ON films.id = film_translations.film_id INNER JOIN languages ON film_translations.language_code = languages.code WHERE languages.code = "en"',(err, result) => {
            if (err) {
                return  res.json({message: "Error getting films. Error: "+err});
            }else if(result){
                return res.json({message:"Films got successfully",body:result});
            }
        })
    }
    return connection.query("SELECT films.id, films.poster_url, films.rating, films.relese_date, films.duration, film_translations.title, film_translations.description, user_favorites.film_id, user_watched.film_id AS watchedFilmId FROM films INNER JOIN film_translations ON films.id = film_translations.film_id INNER JOIN languages ON film_translations.language_code = languages.code INNER JOIN users ON languages.code = users.language_code LEFT JOIN user_favorites ON films.id = user_favorites.film_id AND user_favorites.user_id = users.id LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = users.id WHERE users.id = ?",[userId],(err, result) => {
        if (err) {
            return  res.json({message: "Error getting films. Error: "+err});
        }else if(result){
            return res.json({message:"Films got successfully",body:result});
        }
    })
})

app.post("/likeToggle", (req, res) => {
    const {filmId,userId} = req.body;

    if (!userId) {
        return res.json({message: "You are not logged in!"});
    }

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

app.post("/watchedToggle", (req, res) => {
    const {filmId,userId} = req.body;

    if (!userId) {
        return res.json({message: "You are not logged in!"});
    }

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
app.post("/likedGet", (req, res) => {
    const {userId} = req.body;
    if (!userId) {
        return res.json({message: "You are not logged in!"});
    }

    connection.query("SELECT films.id, films.poster_url, films.rating, films.relese_date, films.duration, film_translations.title, film_translations.description, user_watched.film_id AS watchedFilmId FROM user_favorites INNER JOIN films ON user_favorites.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_watched ON films.id = user_watched.film_id AND user_watched.user_id = user_favorites.user_id WHERE user_favorites.user_id = ? AND film_translations.language_code = (SELECT language_code FROM users WHERE id = ?)",[userId,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while getting favorites. Error: "+err});
        }
        if (result){
            return res.json({message: "Liked got successfully" ,body:result});
        }
    })
})

app.post("/watchedGet", (req, res) => {
    const {userId} = req.body;
    if (!userId) {
        return res.json({message: "You are not logged in!"});
    }

    connection.query("SELECT films.id, films.poster_url, films.rating, films.relese_date, films.duration, film_translations.title, film_translations.description, user_favorites.film_id AS userFavoritesFilms FROM user_watched INNER JOIN films ON user_watched.film_id = films.id INNER JOIN film_translations ON films.id = film_translations.film_id LEFT JOIN user_favorites ON films.id = user_favorites.film_id AND user_favorites.user_id = user_watched.user_id WHERE user_watched.user_id = ? AND film_translations.language_code = (SELECT language_code FROM users WHERE id = ?)",[userId,userId],(err, result) => {
        if (err) {
            return res.json({message: "Error while getting watched. Error: "+err});
        }
        if (result){
            return res.json({message: "Watched got successfully" ,body:result});
        }
    })
})


app.listen(process.env.PORT, () => {
    console.log(`Server started on port ${process.env.PORT}`);
})

