module api

import vweb

['/api/todo/:id';get]  
pub fn (mut app App) get_todo_by_id(id string) vweb.Result{
	
    todo := app.todo_service.get_one_todo(app.db, id) or {
		println(err)
		app.set_status(500, '')
		return app.text('$err')
	}
	
	return app.json(todo)
}