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

import { DataBaseService } from '../../dataBaseService';
import * as uuid from "uuid";
import { PeopleGrowPos } from 'models/MentalHealth/people';
import { LogEnum } from '../../models/MentalHealth/log.enum';
import { LogDAOGrowPos } from './logDAO';
import * as bcrypt from 'bcrypt'

export interface NavData {
    name?: string;
    url?: string;
    icon?: string;
    children?: NavData[];
}

export class PeopleDAOGrowPos {

    private log
    private connection;
    constructor() {
        this.connection = DataBaseService.getInstance();
        this.log = new LogDAOGrowPos()
    }

    public async insertPeople(people: PeopleGrowPos) {
        try {
            let id = uuid.v4();
            people.apppassword = bcrypt.hashSync(people.apppassword, 10)
            people.id = id;
            let con = await this.connection.getConnection()
            let query = await con.query('INSERT INTO people SET ?', [people]);
            con.release();
            return people
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.insertPeople.name}: ${error}`)
            throw new Error(error)
        }
    }

    public async getPeople() {
        try {
            console.log("Obteniendo ");
            let con = await this.connection.getConnection()
            let query = await con.query(`SELECT
                        id,
                        username,
                        '*****' as apppassword,
                        card,
                        visible
                        FROM people;`);
            con.release();
            return query
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.getPeople.name}: ${error}`)
            throw new Error(error)
        }
    }

    public async getPeopleById(peopleId: PeopleGrowPos) {
        try {
            let con = await this.connection.getConnection();
            let query = await con.query(`SELECT
                        id,
                        name,
                        apppassword,
                        card,
                        visible
                        FROM people
                        WHERE id = ?;`, [peopleId.id]);
            con.release();
            return query;
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.getPeopleById.name}: ${error}`)
            return new Error(error);
        }
    }

    public async updatePeople(people: PeopleGrowPos) {
        try {
            people.apppassword = bcrypt.hashSync(people.apppassword, 10)
            let con = await this.connection.getConnection()
            let query = await con.query(`UPDATE people SET
                        name = ?,
                        apppassword = ?,
                        card = ?,
                        visible = ?
                        WHERE id = ?;`,
                [people.name,
                people.apppassword,
                people.card,
                people.visible,
                people.id]);
            con.release();
            return query
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.updatePeople.name}: ${error}`)
            throw new Error(error)
        }
    }

    public async deletePeople(peopleId: string) {
        try {
            let con = await this.connection.getConnection()
            let query = await con.query(`DELETE FROM people 
                        WHERE id = ?;`, [peopleId]);
            con.release();
            return query
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.deletePeople.name}: ${error}`)
            throw new Error(error)
        }
    }

    public async val(id: string, pass: string) {
        try {
            let con = await this.connection.getConnection();
            let query = await con.query(`SELECT
                        id,
                        name,
                        apppassword,
                        card,
                        visible
                        FROM people
                        WHERE name = ? ;`, [id]);
            con.release();
            if (query.length > 0) {
                if (bcrypt.compareSync(pass, query[0].apppassword)) {
                    // Passwords match
                    query[0].apppassword = ''
                    return query
                } else {
                    // Passwords don't match
                    query = []
                    return query
                }
            } else {
                return []
            }
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.val.name}: ${error}`)
            return new Error(error);
        }
    }

    public async getPermissions(query_permissions, result?: Array<NavData>, op?: any) {
        let con = await this.connection.getConnection();
        let sub_menu = new Array();
        if (typeof result !== 'undefined') {
            sub_menu = result;
        }
        let row: NavData;
        let query_permissions_menu = await con.query(`SELECT
                        id_permission, father,
                        name, url, icon,
                        level
                        FROM permissions
                        WHERE father = ?;`, [query_permissions['id_permission']]);
        if (query_permissions_menu.length > 0) {
            let children = new Array<NavData>();
            let row_children: NavData;
            for (let index_permissions_menu = 0; index_permissions_menu < query_permissions_menu.length; index_permissions_menu++) {
                if (query_permissions_menu[index_permissions_menu]['level'] == -1) {
                    let children_son = <Array<NavData>>await this.getPermissions(query_permissions_menu[index_permissions_menu]);
                    children.push(children_son[0]);
                }
                else {
                    if (query_permissions_menu[index_permissions_menu]['level'] == -2) {

                        if (op === "navBar") {
                            let children_son = <Array<NavData>>await this.getPermissions(query_permissions_menu[index_permissions_menu]);
                            children.push(children_son[0]);
                        }
                        else {
                            //let children_son = <Array<NavData>>await this.getPermissions(query_permissions_menu[index_permissions_menu]);
                            //row_children = <NavData>{ name: query_permissions_menu[index_permissions_menu]['name'], url: query_permissions_menu[index_permissions_menu]['url'] + '/' + query_permissions_menu[index_permissions_menu]['id_permission'], icon: query_permissions_menu[index_permissions_menu]['icon'] };
                            row_children = <NavData>{ name: query_permissions_menu[index_permissions_menu]['name'], url: query_permissions_menu[index_permissions_menu]['url'], icon: query_permissions_menu[index_permissions_menu]['icon'] };
                            children.push(row_children);
                            //children.push(children_son[0]);
                        }
                    }
                    else {
                        row_children = <NavData>{ name: query_permissions_menu[index_permissions_menu]['name'], url: query_permissions_menu[index_permissions_menu]['url'], icon: query_permissions_menu[index_permissions_menu]['icon'] };
                        children.push(row_children);
                    }
                }
            }
            row = <NavData>{ name: query_permissions['name'], icon: query_permissions['icon'], url: query_permissions['url'], children: children }
            sub_menu.push(row);
        }
        return sub_menu;
    }

    public async getMenu(peopleId: string, op?: any) {
        let result = new Array();
        try {
            let con = await this.connection.getConnection();
            let query_people_roles = await con.query(`SELECT
                        id_people,
                        id_rol
                        FROM people_roles
                        WHERE id_people = ?;`, [peopleId]);
            if (query_people_roles.length > 0) {
                let row: NavData;
                row = <NavData>{ name: "Escritorio", icon: "icon-speedometer", url: "/dashboard" };
                result.push(row);
                for (let index_people_roles = 0; index_people_roles < query_people_roles.length; index_people_roles++) {
                    let query_permissions_roles = await con.query(`SELECT
                            id_permission,
                            id_rol
                            FROM permissions_roles
                            WHERE id_rol = ?;`, [query_people_roles[index_people_roles]['id_rol']]);
                    if (query_permissions_roles.length > 0) {
                        for (let index_permissions_roles = 0; index_permissions_roles < query_permissions_roles.length; index_permissions_roles++) {
                            let query_permissions = await con.query(`SELECT
                                id_permission,
                                name,
                                icon
                                FROM permissions
                                WHERE id_permission = ? and father = -1;`, [query_permissions_roles[index_permissions_roles]['id_permission']]);
                            if (query_permissions.length > 0) {
                                for (let index_permissions = 0; index_permissions < query_permissions.length; index_permissions++) {
                                    result = await this.getPermissions(query_permissions[index_permissions], result, op);
                                }
                            }
                        }
                    }
                }
            }
            con.release();
            return result;
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.getMenu.name}: ${error}`)
            throw new Error(error)
        }
    }

    public async getSubMenu(permissionId: string) {
        try {
            let con = await this.connection.getConnection();
            let query_permissions = await con.query(`SELECT
                                id_permission,
                                name,
                                icon,
                                url
                                FROM permissions
                                WHERE father = ?;`, permissionId);
            con.release();
            return query_permissions;
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${PeopleDAOGrowPos.name} -> ${this.getMenu.name}: ${error}`)
            throw new Error(error)
        }
    }
}
