module api

import vweb

import utils

['/api/todo/active-status/:id';patch]  
pub fn (mut app App) patch_todo_toggle_active(id string) vweb.Result{

	result := app.todo_service.toggle_todo_active(app.db, id) or {
		eprint('$err')
		return app.json(utils.response[string](false, '$err'))
	}

	app.set_status(200, '')
	return app.json(utils.response[string](true, result))
}

