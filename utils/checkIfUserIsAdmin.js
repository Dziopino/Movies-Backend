function checkIfUserIsAdmin(connection, userId, callback){

    connection.query("SELECT role FROM users WHERE id = ?", [userId], (err, result)=>{
            if(err){
                return callback(err);
            }

            if(result.length === 0){
                return callback(null, false, true);
            }

            callback(null, result[0].role === 1, false);
        }
    );

}

module.exports = checkIfUserIsAdmin;