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

import { LogGrowPos } from "./models/MentalHealth/log";
import { LogEnum } from "./models/MentalHealth/log.enum";
import * as socketio from "socket.io"
import { ExternalPlatformDAOGrowPos } from "./repository/mentalHealthDB/external_platformDAO";
import { LogDAOGrowPos } from "./repository/mentalHealthDB/logDAO";
import { ExternalPlatformGrowPos } from "./models/MentalHealth/external_platform";
import { resolve } from "url";

const axios = require('axios');
const external_platform = new ExternalPlatformDAOGrowPos()

export class HttpRequestService {

    private static instance: HttpRequestService;

    private log: LogDAOGrowPos
    private host: string
    private api_key: string
    private headers: any
    private token: string

    private constructor() {
        this.headers = {}
        this.headers['Access-Control-Allow-Origin'] = '*';
        this.log = new LogDAOGrowPos()
        this.getExternalPLatform()
    }

    private async getExternalPLatform() {
        try {
            let res = await external_platform.getExternalPlatform()
            this.host = res[0].url
            this.api_key = res[0].api_key
            this.connectWithExternalPlatform()
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${HttpRequestService.name} -> ${this.getExternalPLatform.name}: ${error}`)
        }
    }

    static getInstance() {
        try {
            if (!HttpRequestService.instance) {
                HttpRequestService.instance = new HttpRequestService();
            }
            return HttpRequestService.instance;
        } catch (error) {
            console.log('An error occurred while the instance was returned ' + error + ` ${HttpRequestService.name} -> ${this.getInstance.name}`);
        }
    }

    private async connectWithExternalPlatform() {
        try {
            let res: any = await this.post(`/platform/val`,{api_key: this.api_key})
            this.token = res.tokenReturn
        } catch (error) {
            this.log.insertLog(LogEnum.ERROR, `${HttpRequestService.name} -> ${this.connectWithExternalPlatform.name}: ${error}`)
        }
    }

    public post(url: string, data: any, tries = 1) {
        return new Promise(async (resolve, reject) => {
            try {
                this.headers['Authorization'] = 'Bearer ' + this.token
                let response = await axios({ method: 'post', url: this.host + url, headers: this.headers, data })
                if (response.status === 200 || response.status === 201) {
                    resolve(response.data)
                } else if (response.status === 403) {
                    await this.connectWithExternalPlatform()
                    if (tries >= 5) {
                        reject()
                    }
                    this.post(url, data, tries++)
                } else {
                    reject()
                }
            } catch (error) {
                this.log.insertLog(LogEnum.ERROR, `${HttpRequestService.name} -> ${this.post.name}: ${error}`)
            }
        })
    }

}

