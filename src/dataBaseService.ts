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

import * as mysql from "mysql";
import * as util from "util";
import { LogGrowPos } from "./models/MentalHealth/log";
import { LogEnum } from "./models/MentalHealth/log.enum";
import * as dotenv from 'dotenv'


export class DataBaseService {
    private log
    private static instance: DataBaseService;
    private connection;

    private constructor() {
        try {
            dotenv.config();
            this.connection = mysql.createPool({
                connectionLimit: 100,
                host: process.env.HOST,
                user: process.env.DBUSER,
                password: process.env.PASSWORD,
                database: process.env.DATABASE,
                timezone: process.env.TIMEZONE,
                
                typeCast: function castField(field, useDefaultTypeCasting) {
                    // We only want to cast bit fields that have a single-bit in them. If the field
                    // has more than one bit, then we cannot assume it is supposed to be a Boolean.
                    if ((field.type === "BIT") && (field.length === 1)) {

                        var bytes = field.buffer();

                        // A Buffer in Node represents a collection of 8-bit unsigned integers.
                        // Therefore, our single "bit field" comes back as the bits '0000 0001',
                        // which is equivalent to the number 1.
                        return (bytes[0] === 1);

                    }

                    return (useDefaultTypeCasting());

                }
            });
            this.connection.getConnection((err, connection) => {
                if (err) {
                    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
                        console.error('Database connection was closed.')
                    }
                    if (err.code === 'ER_CON_COUNT_ERROR') {
                        console.error('Database has too many connections.')
                    }
                    if (err.code === 'ECONNREFUSED') {
                        console.error('Database connection was refused.')
                    }
                }
                if (connection) connection.release()

                return
            })
            this.log = new LogGrowPos()
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${DataBaseService.name} -> ${this.constructor.name}: ${error}`)
            console.log('An error occurred while the connection was created ' + error + ` ${DataBaseService.name} -> constructor`);
        }
    }

    static getInstance() {
        try {
            if (!DataBaseService.instance) {
                DataBaseService.instance = new DataBaseService();
            }
            return DataBaseService.instance;
        } catch (error) {
            //this.log.insertLog(LogEnum.ERROR, `${DataBaseService.name} -> ${this.getInstance.name}: ${error}`)
            console.log('An error occurred while the instance was returned ' + error + ` ${DataBaseService.name} -> ${this.getInstance.name}`);
        }
    }

    public getConnection() {
        try {
            return new Promise((resolve, reject) => {
                try {
                    this.connection.getConnection((err, connection) => {
                        if (err) {
                            reject(err);
                        }
                        connection.query = util.promisify(connection.query).bind(connection)
                        connection.beginTransaction = util.promisify(connection.beginTransaction).bind(connection)
                        connection.commit = util.promisify(connection.commit).bind(connection)
                        resolve(connection)
                    });
                } catch (error) {
                    this.log.insertLog(LogEnum.ERROR, `${DataBaseService.name} -> ${this.getConnection.name} promise: ${error}`)
                }
            });
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${DataBaseService.name} -> ${this.getConnection.name}: ${error}`)
        }
    }



    public query(sql, args) {
        return new Promise((resolve, reject) => {
            this.connection.query(sql, args, (err, rows) => {
                if (err)
                    return reject(err);
                resolve(rows);
            });
        });
    }


}

