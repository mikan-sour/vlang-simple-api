module service

import mysql

pub interface TodoService {
mut:
        get_todos(db mysql.Connection, query map[string]string) ![]map[string]string
        get_one_todo(db mysql.Connection, id string) !map[string]string
        // pub fn create_new_todo()
        // pub fn update_todo()
        // pub fn toggle_todo_active()
        pub fn delete_todo()
}

[heap]
pub struct TodoServiceImpl {}

pub fn new_todo_service() &TodoServiceImpl {
		return &TodoServiceImpl{}
}

pub fn (ts &TodoServiceImpl) get_todos(db mysql.Connection, query map[string]string) ![]map[string]string {
		
	mut todo_query := 'SELECT * FROM todos WHERE 1 = 1'
        todo_text := query['todo_text']
        if todo_text != '' {
                todo_query += " AND todo_text LIKE '%${todo_text}%'"
        }

        active := query['active']
        if active != '' {
                todo_query += ' AND active = ${active}'
        }

        limit := query['limit']
        if limit.int() > 0 {
                todo_query += ' LIMIT ${limit}'
        } else {
                todo_query += ' LIMIT 20'
        }

        offset := query['offset']
        if offset.int() > 0 {
                todo_query += ' OFFSET ${offset}'
        } else {
                todo_query += ' OFFSET 0'
        }

        todo_query += ';'

        todo_result := db.query(todo_query) or {
                eprint('${err}')
                return error('get_todos service failed, db cannot close: ${err}')
        }

        return todo_result.maps()

}

pub fn (ts &TodoServiceImpl) get_one_todo(db mysql.Connection, id string) !map[string]string {
	todo_result := db.query('SELECT * FROM todos WHERE id = $id.int() LIMIT 1;') or {
		eprint('${err}')
        return error('get_one_todo service failed, db query: ${err}')
	}

    return todo_result.maps()[0]
}