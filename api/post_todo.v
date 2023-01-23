module api

import json
import vweb

import repository
import utils

['/api/todo';post]  
pub fn (mut app App) post_todo() vweb.Result{

	body := json.decode(repository.Todo, app.req.data) or {
        app.set_status(400, '')
		return app.json(utils.response[string](false, 'Failed to decode json, error: $err'))
	}

	result := app.todo_service.create_new_todo(app.db, body.todo_text) or {
		app.set_status(500, '')
		return app.json(utils.response[string](false, '$err'))
	}

	app.set_status(201, '')
	return app.json(utils.response[string](result, 'ok'))
}