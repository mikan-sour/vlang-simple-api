module repository

import time

[table: 'todos']
pub struct Todo {
	id        	int    					[primary; sql: serial]
	todo_text   string 					[nonull]
	active 		bool 	   		[nonull; default: true]
	created_at  time.Time  [default: 'CURRENT_TIMESTAMP'; sql_type: 'TIMESTAMP']
    updated_at  time.Time   [default: 'CURRENT_TIMESTAMP'; sql_type: 'TIMESTAMP']
}

pub fn is_true(str string) bool {
	if str == '1' {
		return true
	} else {
		return false
	}
}

pub fn parse_todo(raw map[string]string) !Todo {
	return Todo{
		id:raw['id'].int(),
		todo_text: raw['todo_text'],
		active: is_true(raw['active']),
		created_at: time.parse(raw['created_at'])!,
		updated_at: time.parse(raw['updated_at'])!
	}
}