module api

import vweb

import utils

['/api/todo/:id';get]  
pub fn (mut app App) get_todo_by_id(id string) vweb.Result{
	
    todo := app.todo_service.get_one_todo(app.db, id) or {
		println(err)
		app.set_status(500, '')
		return app.json(utils.response[string](false, '$err'))
	}
	
	return app.json(utils.response[map[string]string](true, todo))

}