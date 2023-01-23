module api

import time
import vweb

['/api/todo/active-status/:id';patch]  
pub fn (mut app App) patch_todo_toggle_active(id string) vweb.Result{

	updated_at := time.now().format_ss()

	app.db.query('UPDATE todos SET active = !active,  updated_at = "$updated_at" WHERE id = $id.int();') or {
		println(err)
		app.set_status(500, '')
		return app.text('$err')
	}

	app.set_status(200, '')
	return app.text('$updated_at')
}

