module repository

import time

[table: 'todos']
pub struct Todo {
pub:
	id        	int    					
	created_at  time.Time 
pub mut:
	todo_text   string 		
	active 		bool 	   		
    updated_at  time.Time  
}