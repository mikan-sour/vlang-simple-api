module api

import json
import vweb

import repository
import utils

['/api/todo/:id';patch]  
pub fn (mut app App) patch_todo(id string) vweb.Result{

	body := json.decode(repository.Todo, app.req.data) or {
        app.set_status(400, '')
		return app.json(utils.response[string](false, 'Failed to decode json, error: $err'))
	}

	if body.todo_text == '' {
		app.set_status(400, '')
		return app.json(utils.response[string](false, 'no todo_text was sent in patch request.'))
	}

	updated_at := app.todo_service.update_todo(app.db, id, body.todo_text) or {
		app.set_status(500, '')
		return app.json(utils.response[string](false, '$err'))
	}

	app.set_status(200, '')
	return app.json(utils.response[string](true, updated_at))
}

