module main

import context

import mikan-sour.mikanvex.router
import mikan-sour.mikanvex.server
import mikan-sour.mikanvex.ctx
import zztkm.vdotenv

import api 
import database

fn print_req_info(mut req ctx.Req, mut res ctx.Resp) {

	println('${req.method} ${req.path}')
}



fn main() {

    vdotenv.load()

    database_instance := database.db_init()!

 	mut router := router.new()
    app_ctx := context.with_value(context.todo(), database.db_ctx_key, database_instance)
	router.inject_context(app_ctx)

    mut app := api.new_api( router)
    app.router.use(print_req_info)

    app.router.route(.get, '/', fn (req &ctx.Req, mut res ctx.Resp) {
        res.send_file('index.html', 200)
    })

    app.router.route(.get, '/health', api.healthcheck)
    app.router.route(.get, '/todo/:id', api.get_todo_by_id)
    app.router.route(.patch,'/todo/:id', api.patch_todo)

    app.router.route(.post, '/todo', api.post_todo)

    server.serve(app.router, 6789)
}