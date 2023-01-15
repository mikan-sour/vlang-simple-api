module api

import time

import database
import repository

import mikan-sour.mikanvex.ctx

pub fn post_todo(req &ctx.Req, mut res ctx.Resp){

	mut db := database.get_db(req) or {
		println(err)
		res.send_status(500)
		return
	}

	mut post_data := req.parse_form() or {
		eprintln('Failed to parse form data.')
		res.send_status(500)
		return
	}

	todo_text := post_data['todo_text']

	db.query('INSERT INTO todos (todo_text) VALUES ("$todo_text")') or {
		eprintln(err)
		res.send_status(500)
		return
	}

	res.send_status(201)
}