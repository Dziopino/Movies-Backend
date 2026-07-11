const bcrypt = require("bcrypt");

const salt = 10;

function hashPassword(password) {
    return new Promise((resolve, reject) => {
        bcrypt.hash(password, salt, (err, hash) => {
            if (err) {
                reject(err);
            } else {
                resolve(hash);
            }
        });
    });
}

module.exports = hashPassword;