module main

import pg
import os

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
    
    db := pg.connect(pg.Config {
		host: os.getenv('DB_HOST'),
		port: os.getenv('DB_PORT').int(),
		user: os.getenv('DB_USER'),
		password: os.getenv('DB_PASSWORD'),
		dbname: os.getenv('DB_NAME'),
	})!

    println(db)

 	mut app := router.new()
    app.use( print_req_info)

    app.route(.get, '/', fn (req &ctx.Req, mut res ctx.Resp) {
        res.send_file('index.html', 200)
    })

    app.route(.get, '/health', api.healthcheck)

    server.serve(app, 6789)
}