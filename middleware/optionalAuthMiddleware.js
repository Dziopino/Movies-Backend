const jwt = require("jsonwebtoken");

function optionalAuthMiddleware(req, res, next) {

    const authHeader = req.headers.authorization;

    if (!authHeader) {
        req.user = null;
        return next();
    }

    const token = authHeader.split(" ")[1];

    if (!token) {
        req.user = null;
        return next();
    }

    try {
        req.user = jwt.verify(token, process.env.JWT_SECRET);
    } catch (err) {
        req.user = null;
    }

    next();
}

module.exports = optionalAuthMiddleware;