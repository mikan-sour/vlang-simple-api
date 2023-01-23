module api

import vweb

import utils

['/api/todo';get]  
pub fn (mut app App) get_todos() vweb.Result{

	todos := app.todo_service.get_todos(app.db, app.query) or {
		eprint('$err')
		app.set_status(500, '')
		return app.json(utils.response[string](false, '$err'))
	}
	
	return app.json(utils.response[[]map[string]string](true, todos))
}