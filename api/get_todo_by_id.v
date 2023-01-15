module api

import time
import mysql

import database
import repository

import mikan-sour.mikanvex.ctx

pub fn get_todo_by_id(req &ctx.Req, mut res ctx.Resp){

	mut db := database.get_db(req) or {
		println(err)
		res.send_status(500)
		return
	}

	

	id := req.params['id']

	todo_result := db.query('SELECT * FROM todos WHERE id = ${id.int()} LIMIT 1;') or {
		println(err)
		res.send_status(500)
		return
	}

    todo_raw := todo_result.maps()[0]
	todo := repository.parse_todo(todo_raw) or {
		println(err)
		res.send_status(500)
		return
	}
	
	res.send_json<repository.Todo>(todo,200)
}