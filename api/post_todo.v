module api

import json
import vweb

import repository

['/api/todo';post]  
pub fn (mut app App) post_todo() vweb.Result{

	body := json.decode(repository.Todo, app.req.data) or {
        app.set_status(400, '')
        return app.text('Failed to decode json, error: $err')
	}

	app.db.query('INSERT INTO todos (todo_text) VALUES ("$body.todo_text")') or {
		println(err)
		app.set_status(500, '')
		return app.text('$err')
	}

	app.set_status(201, '')
	return app.text('ok')
}