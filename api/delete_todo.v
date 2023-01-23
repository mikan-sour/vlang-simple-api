// DELETE FROM todos WHERE id = 5;
module api

import vweb

['/api/todo/:id';delete]  
pub fn (mut app App) delete_todo(id string) vweb.Result{

	app.db.query('DELETE FROM todos WHERE id = $id.int();') or {
		println(err)
		app.set_status(500, '')
		return app.text('$err')
	}

	return app.text('ok')
}