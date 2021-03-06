
import { Request, Response } from "express";
import { PeopleDAOGrowPos } from "../repository/mentalHealthDB/peopleDAO";
import { Token } from "../models/interfaces/token.interface";
import { ErrorGrowPos } from "../models/MentalHealth/error";
import * as jwt from 'jsonwebtoken'
import { } from "express-jwt";

let people = new PeopleDAOGrowPos();

export class PeopleController {
	/*-------------------------------- app --------------------------------------------------------*/
	public async insertPeople(req: Request, res: Response, next) {
		try {
			res.send(await people.insertPeople(req.body));
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 400
			next(err);
			console.log(
				"An error occurred while inserting user :" +
				error +
				`: ${PeopleController.name} -> insertPeople`
			);
		}
	}

	public async getPeople(req: Request, res: Response, next) {
		try {
			console.log("Aqui");
			res.send(await people.getPeople());
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 404
			next(err);
			console.log(
				"An error occurred while getting users :" +
				error +
				`: ${PeopleController.name} -> getPeople`
			);
		}
	}

	public async getPeopleById(req: Request, res: Response, next) {
		try {
			res.send(await people.getPeopleById(req.body));
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 404
			next(err);
			console.log(
				"An error occurred while getting user :" +
				error +
				`: ${PeopleController.name} -> getPeopleById`
			);
		}
	}

	public async updatePeople(req: Request, res: Response, next) {
		try {
			res.send(await people.updatePeople(req.body));
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 400
			next(err);
			console.log(
				"An error occurred while updating user :" +
				error +
				`: ${PeopleController.name} -> updatePeople`
			);
		}
	}

	public async deletePeople(req: Request, res: Response, next) {
		try {
			res.send(await people.deletePeople(req.body.id));
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 500
			next(err);
			console.log(
				"An error occurred while deleting user :" +
				error +
				`: ${PeopleController.name} -> deletePeople`
			);
		}
	}

	public async getMenu(req: Request, res: Response, next) {
		try {
			res.send(await people.getMenu(req.body.id, req.body.op));
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 500
			next(err);
			console.log(
				"An error occurred while get menu :" +
				error +
				`: ${PeopleController.name} -> getMenu`
			);
		}
	}

	public async getSubMenu(req: Request, res: Response, next) {
		try {
			res.send(await people.getSubMenu(req.body.id));
		} catch (error) {
			let err: ErrorGrowPos = new Error(error);
			err.status = 500
			next(err);
			console.log(
				"An error occurred while get sub menu :" +
				error +
				`: ${PeopleController.name} -> getSubMenu`
			);
		}
	}
}