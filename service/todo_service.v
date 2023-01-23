module service

import mysql
import time

pub interface TodoService {
mut:
        get_todos(db mysql.Connection, query map[string]string) ![]map[string]string
        get_one_todo(db mysql.Connection, id string) !map[string]string
        create_new_todo(db mysql.Connection, text string)!bool
        update_todo(db mysql.Connection, id string, text string) !string
        toggle_todo_active(db mysql.Connection, id string) !string
        delete_todo(db mysql.Connection, id string) !bool
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

    result := todo_result.maps()[0] or {
        return error('no record with id ${id} in the database')
    }

    return result
}

pub fn (ts &TodoServiceImpl) create_new_todo(db mysql.Connection, text string)!bool {
        db.query('INSERT INTO todos (todo_text) VALUES ("$text")')!
        return true
}

pub fn (ts &TodoServiceImpl) update_todo(db mysql.Connection, id string, text string) !string {
        updated_at := time.now().format_ss()
        db.query('UPDATE todos SET todo_text = "$text",  updated_at = "$updated_at" WHERE id = $id.int();')!
        return updated_at
}

pub fn (ts &TodoServiceImpl) toggle_todo_active(db mysql.Connection, id string) !string {
        updated_at := time.now().format_ss()
        db.query('UPDATE todos SET active = !active,  updated_at = "$updated_at" WHERE id = $id.int();')!
        return updated_at
}

pub fn (ts &TodoServiceImpl) delete_todo(db mysql.Connection, id string) !bool {
        db.query('DELETE FROM todos WHERE id = $id.int();')!
        return true
}
