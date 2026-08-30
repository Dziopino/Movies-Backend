const connection = require("../database");

const getDashboardOverview = async (req, res) => {
    try {
        const queries = {
            totalMovies: new Promise((resolve, reject) => {
                connection.query("SELECT COUNT(*) AS count FROM films", (err, result) => {
                    if (err) reject(err);
                    else resolve(result[0].count);
                });
            }),
            totalUsers: new Promise((resolve, reject) => {
                connection.query("SELECT COUNT(*) AS count FROM users", (err, result) => {
                    if (err) reject(err);
                    else resolve(result[0].count);
                });
            }),
            totalLogs: new Promise((resolve, reject) => {
                connection.query("SELECT COUNT(*) AS count FROM user_activity", (err, result) => {
                    if (err) reject(err);
                    else resolve(result[0].count);
                });
            }),
            lineChartData: new Promise((resolve, reject) => {
                connection.query(
                    `SELECT DATE(created_at) as date, COUNT(*) as value
                     FROM user_activity
                     WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
                     GROUP BY DATE(created_at)
                     ORDER BY date ASC`,
                    (err, result) => {
                        if (err) reject(err);
                        else resolve(result);
                    }
                );
            }),
            pieChartData: new Promise((resolve, reject) => {
                connection.query(
                    `SELECT action as name, COUNT(*) as value
                     FROM user_activity
                     GROUP BY action
                     ORDER BY value DESC
                     LIMIT 5`,
                    (err, result) => {
                        if (err) reject(err);
                        else resolve(result);
                    }
                );
            })
        };

        const [totalMovies, totalUsers, totalLogs, lineChartData, pieChartData] = await Promise.all([
            queries.totalMovies,
            queries.totalUsers,
            queries.totalLogs,
            queries.lineChartData,
            queries.pieChartData
        ]);

        res.json({
            success: true,
            kpi: {
                totalMovies,
                totalUsers,
                totalLogs,
                savedSpace: '74%'
            },
            lineChartData,
            pieChartData
        });

    } catch (error) {
        console.error('Dashboard overview error:', error);
        res.status(500).json({
            success: false,
            message: 'database_error'
        });
    }
};

const getUsersAnalytics = async (req, res) => {
    try {
        const queries = {
            bannedCount: new Promise((resolve, reject) => {
                connection.query(
                    "SELECT COUNT(*) AS count FROM user_activity WHERE action = 'USER_BANNED'",
                    (err, result) => {
                        if (err) reject(err);
                        else resolve(result[0].count);
                    }
                );
            }),
            suspendedCount: new Promise((resolve, reject) => {
                connection.query(
                    "SELECT COUNT(*) AS count FROM user_activity WHERE action = 'USER_SUSPENDED'",
                    (err, result) => {
                        if (err) reject(err);
                        else resolve(result[0].count);
                    }
                );
            }),
            registrationChartData: new Promise((resolve, reject) => {
                connection.query(
                    `SELECT DATE(created_at) as date, COUNT(*) as value
                     FROM user_activity
                     WHERE action = 'USER_REGISTERED'
                     AND created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
                     GROUP BY DATE(created_at)
                     ORDER BY date ASC`,
                    (err, result) => {
                        if (err) reject(err);
                        else resolve(result);
                    }
                );
            })
        };

        const [bannedCount, suspendedCount, registrationChartData] = await Promise.all([
            queries.bannedCount,
            queries.suspendedCount,
            queries.registrationChartData
        ]);

        res.json({
            success: true,
            moderationStats: {
                bannedCount,
                suspendedCount
            },
            registrationChartData
        });

    } catch (error) {
        console.error('Users analytics error:', error);
        res.status(500).json({
            success: false,
            message: 'database_error'
        });
    }
};

const getAuditLogs = async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const actionFilter = req.query.action || '';
        const usernameFilter = req.query.username || '';
        const offset = (page - 1) * limit;

        let whereClauses = [];
        let queryParams = [];

        if (actionFilter) {
            whereClauses.push('user_activity.action = ?');
            queryParams.push(actionFilter);
        }

        if (usernameFilter) {
            whereClauses.push('users.username LIKE ?');
            queryParams.push(`%${usernameFilter}%`);
        }

        const whereSQL = whereClauses.length > 0 ? `WHERE ${whereClauses.join(' AND ')}` : '';

        const logsQuery = `
            SELECT
                user_activity.id,
                user_activity.action,
                user_activity.created_at,
                users.username,
                users.id as user_id
            FROM user_activity
            INNER JOIN users ON user_activity.user_id = users.id
            ${whereSQL}
            ORDER BY user_activity.created_at DESC
            LIMIT ? OFFSET ?
        `;

        const countQuery = `
            SELECT COUNT(*) as total
            FROM user_activity
            INNER JOIN users ON user_activity.user_id = users.id
            ${whereSQL}
        `;

        const logsPromise = new Promise((resolve, reject) => {
            connection.query(logsQuery, [...queryParams, limit, offset], (err, result) => {
                if (err) reject(err);
                else resolve(result);
            });
        });

        const countPromise = new Promise((resolve, reject) => {
            connection.query(countQuery, queryParams, (err, result) => {
                if (err) reject(err);
                else resolve(result[0].total);
            });
        });

        const [logs, totalRows] = await Promise.all([logsPromise, countPromise]);
        const totalPages = Math.ceil(totalRows / limit);

        res.json({
            success: true,
            logs,
            pagination: {
                currentPage: page,
                totalPages,
                totalRows
            }
        });

    } catch (error) {
        console.error('Audit logs error:', error);
        res.status(500).json({
            success: false,
            message: 'database_error'
        });
    }
};

module.exports = {
    getDashboardOverview,
    getUsersAnalytics,
    getAuditLogs
};
