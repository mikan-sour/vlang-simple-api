// DELETE FROM todos WHERE id = 5;
module api

import vweb

import utils

struct DeleteResponse {
	deleted string
}

['/api/todo/:id';delete]  
pub fn (mut app App) delete_todo(id string) vweb.Result{

	result := app.todo_service.delete_todo(app.db, id) or {
		app.set_status(500, '')
		return app.json(utils.response[string](false, '$err'))
	}

	return app.json(utils.response[DeleteResponse](result, DeleteResponse{ deleted: id }))
}