//    MentalHealth
//    Copyright (c) 2021 MentalHealth
//    http://MentalHealth.co
//
//      Andrés Mauricio Martínez Hincapié
//      Juan Pablo Ángel Vallejo
//
//    This file is part of MentalHealth
//    GrowPos is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    GrowPos is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with GrowPos.  If not, see <http://www.gnu.org/licenses/>.

import {Request, Response, NextFunction} from "express";
import { PeopleController } from "../controllers/peopleController";
import * as auth from '../authService'
var cors = require('cors');
export class PeopleRoutes { 
    
    public peopleController: PeopleController = new PeopleController();

    public routes(app): void {   
        
        app.use(cors());

        app.route('/user')
        .post(auth,this.peopleController.insertPeople)

        app.route('/user/get')
        .post(auth,this.peopleController.getPeople)

        app.route('/user/getById')
        .post(auth,this.peopleController.getPeopleById)

        app.route('/user/update')
        .post(auth,this.peopleController.updatePeople)

        app.route('/user/delete')
        .post(auth,this.peopleController.deletePeople)

        app.route('/user/get_menu')
        .post(auth,this.peopleController.getMenu)

        app.route('/user/get_sub_menu')
        .post(auth,this.peopleController.getSubMenu)
    }
}