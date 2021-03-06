
import { Request, Response } from "express";
import { PeopleDAOGrowPos } from "../repository/mentalHealthDB/peopleDAO";
import { Token } from "../models/interfaces/token.interface";
import { ErrorGrowPos } from "../models/MentalHealth/error";
import * as jwt from 'jsonwebtoken'
import { ExternalPlatformDAOGrowPos } from "../repository/mentalHealthDB/external_platformDAO";
import { } from "express-jwt";

let people = new PeopleDAOGrowPos();
let external_platform = new ExternalPlatformDAOGrowPos();

export class AuthController {
	/*-------------------------------- app --------------------------------------------------------*/

	public async valUser(req: Request, res: Response, next) {
		try {

			var result = await people.val(req.body.name, req.body.apppassword);

			let token: Token;
			if (result.length > 0) {
				result.map((item: any) => {
					token = {
						id: item.id,
						name: item.name,
						rol: item.role,
						password: item.apppassword
					};
				});
				var tokenReturn = jwt.sign(token, "fcasc3210sdfjnmku+98KJH45f", {
					expiresIn: 60 * 60 * 24 // expires in 24 hours
				});		
				res.send({
					user: result[0],
					tokenReturn
				});
			} else {
				let err: ErrorGrowPos = new Error('Incorrect user or password');
				err.status = 403
				next(err);
			}
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 500
			next(err);
			console.log(
				"An error occurred while validating user :" +
				error +
				`: ${AuthController.name} -> val`
			);
		}
	}

	public async valPlatform(req: Request, res: Response, next) {
		try {

			var result = await external_platform.val(req.body.api_key);

			let token: Token;
			if (result.length > 0) {
				result.map((item: any) => {
					token = {
						id: item.id,
						name: item.name,
						rol: '',
						password: ''
					};
				});
				var tokenReturn = jwt.sign(token, "fcasc3210sdfjnmku+98KJH45f", {
					expiresIn: 60 * 60 * 24 // expires in 24 hours
				});		
				res.send({
					user: result[0],
					tokenReturn
				});
			} else {
				let err: ErrorGrowPos = new Error('API KEY no registered');
				err.status = 403
				next(err);
			}
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 500
			next(err);
			console.log(
				"An error occurred while validating platform :" +
				error +
				`: ${AuthController.name} -> val`
			);
		}
	}
}