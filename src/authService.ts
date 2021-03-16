import { ErrorGrowPos } from "./models/MentalHealth/error";
import * as jwt from 'jsonwebtoken'

const auth = (req, res, next) => {
    var token = req.headers['authorization']
    /*if (!token) {
        let error: ErrorGrowPos = new Error('Token Not Found');
        error.status = 401
        next(error);
        return;
    }*/
    token = token.replace('Bearer ', '')

    /*jwt.verify(token, 'fcasc3210sdfjnmku+98KJH45f', (err, user) => {
        console.log("heeee");
        if (err) {
            let error: ErrorGrowPos = new Error('Invalid Token');
            error.status = 401
            next(error);
        } else {

            res.locals.user = user
            next()
        }
    })*/
    res.locals.user = "ok"
    next()
    return
}

module.exports = auth