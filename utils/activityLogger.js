const db = require("../database");

/**
 * Logs user activity to the user_activity table
 * @param {number} userId - The ID of the user performing the action
 * @param {string} action - The action type from the ENUM (e.g., 'USER_REGISTERED', 'FILM_LIKED')
 * @param {object|null} poolConnection - Optional transaction connection object. If provided, uses this connection; otherwise uses default db connection
 * @returns {Promise<void>}
 */
async function logActivity(userId, action, poolConnection = null) {
    return new Promise((resolve, reject) => {
        try {
            const query = "INSERT INTO user_activity (user_id, action) VALUES (?, ?)";
            const values = [userId, action];

            if (poolConnection) {
                poolConnection.query(query, values, (err) => {
                    if (err) {
                        console.error(`[ActivityLogger] Error logging activity: ${action} for user ${userId}`, err);
                        return reject(err);
                    }
                    resolve();
                });
            } else {
                db.query(query, values, (err) => {
                    if (err) {
                        console.error(`[ActivityLogger] Error logging activity: ${action} for user ${userId}`, err);
                        return reject(err);
                    }
                    resolve();
                });
            }
        } catch (error) {
            console.error(`[ActivityLogger] Exception in logActivity:`, error);
            reject(error);
        }
    });
}

module.exports = logActivity;
