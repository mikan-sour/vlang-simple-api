module api

import time

import database
import repository

import mikan-sour.mikanvex.ctx

pub fn patch_todo(req &ctx.Req, mut res ctx.Resp){

	mut db := database.get_db(req) or {
		println(err)
		res.send_status(500)
		return
	}

	mut patch_data := req.parse_form() or {
		eprintln('Failed to parse form data.')
		res.send_status(500)
		return
	}

	todo_id := patch_data['id'].int()
	todo_text := patch_data['todo_text']
	todo_active := repository.is_true(patch_data['todo_active'])
	todo_updated_at := time.now().format_ss()

	db.query('INSERT INTO todos (todo_text, active, updated_at) VALUES ("$todo_text", $todo_active, "$todo_updated_at") WHERE id == $todo_id') or {
		eprintln(err)
		res.send_status(500)
		return
	}

	res.send_status(201)
}