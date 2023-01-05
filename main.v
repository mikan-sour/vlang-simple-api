module main

import postgres

import nedpals.vex.router
import nedpals.vex.server
import nedpals.vex.ctx
import zztkm.vdotenv

import api 

fn print_req_info(mut req ctx.Req, mut res ctx.Resp) {
	println('${req.method} ${req.path}')
}

fn main() {

    vdotenv.load()

    mut connection := mysql.Connection{
        username: 'mysql'
        password: 'mysql'
        dbname: 'todos'
        port: 3306
        host: 'localhost'
    }

    connection.connect()!

 	mut app := router.new()
    app.use(print_req_info)

    app.route(.get, '/', fn (req &ctx.Req, mut res ctx.Resp) {
        res.send_file('index.html', 200)
    })

    app.route(.get, '/health', api.healthcheck)

    server.serve(app, 6789)
}