function logActivity(connection, userId, action){

    connection.query("INSERT INTO user_activity(user_id, action) VALUES (?,?)", [userId, action]);

}

module.exports = logActivity;