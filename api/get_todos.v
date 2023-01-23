module api

import vweb

['/api/todo';get]  
pub fn (mut app App) get_todos() vweb.Result{

	todos := app.todo_service.get_todos(app.db, app.query) or {
		eprint('$err')
		app.set_status(500, '')
		return app.text('$err')
	}
	
	return app.json(todos)
}