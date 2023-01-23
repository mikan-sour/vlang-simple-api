module api

import json
import time
import vweb

import repository

['/api/todo/:id';patch]  
pub fn (mut app App) patch_todo(id string) vweb.Result{

	body := json.decode(repository.Todo, app.req.data) or {
        app.set_status(400, '')
        return app.text('Failed to decode json, error: $err')
	}

	if body.todo_text == '' {
		app.set_status(400, '')
        return app.text('no todo_text was sent in patch request.')
	}

	updated_at := time.now().format_ss()

	app.db.query('UPDATE todos SET todo_text = "$body.todo_text",  updated_at = "$updated_at" WHERE id = $id.int();') or {
		println(err)
		app.set_status(500, '')
		return app.text('$err')
	}

	app.set_status(200, '')
	return app.text('$updated_at')
}

