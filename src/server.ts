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

import app from './app';
import {SocketService} from "./socketService"
import * as http from "http"
import * as dotenv from "dotenv"

dotenv.config();
const PORT = `${process.env.PORT}`;
const HOST = `${process.env.HOST}`
const server = http.createServer(app);
const sockets = SocketService.start(server)
/*
const io = socketio(server)
io.origins('*:*') // for latest version
io.on('connection', (socket) => {
    socket.emit('order', 'hello')
    console.log('a user connected');
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
    socket.on('my message', (msg) => {
        console.log('message: ' + msg);
    });

});*/
//io.emit() for bradcast

server.listen(PORT, () => {
    console.log('MentalHeal server listening on port ' + PORT);
})