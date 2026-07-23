const jwt = require("jsonwebtoken");
const connection = require("../database")

function authMiddleware(req,res,next) {

    const authHeader = req.headers.authorization;

    if(!authHeader){
        return res.status(401).json({message:"No token provided"});
    }

    const token = authHeader.split(" ")[1];

    if(!token){
        return res.status(401).json({message:"Invalid token format"});
    }

    try {

        const decoded = jwt.verify(token,process.env.JWT_SECRET);

        connection.query("SELECT id,status,suspended_until FROM users WHERE id = ?", [decoded.id], (err,result)=>{

            if(err){
                return res.status(500).json({message:"Database error"});
            }

            if(result.length === 0){
                return res.status(401).json({message:"User not found"});
            }

            const user = result[0];


            if(user.status === "BANNED"){
                return res.status(403).json({message:"Account banned", banned:true});
            }


            if(user.status === "SUSPENDED"){

                if(new Date(user.suspended_until) > new Date()){
                    return res.status(403).json({message:"Account suspended", suspended:true, suspendedUntil:user.suspended_until});
                }

                connection.query("UPDATE users SET status='ACTIVE', suspended_until=NULL, suspend_reason=NULL, suspended_at=NULL, suspended_by=NULL WHERE id=?", [user.id], (err)=>{
                        if(err){
                            return res.status(500).json({message:"Database error"});
                        }
                        req.user = decoded;
                        next();
                    }
                );
                return;
            }
            req.user = decoded;
            next();
        });
    } catch(err) {

        return res.status(401).json({
            message:"Invalid or expired token"
        });

    }
}

module.exports = authMiddleware;