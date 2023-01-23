module database

import mysql
import os
import time

pub fn db_init() !mysql.Connection {
	mut db := mysql.Connection{
		username: os.getenv('DB_USERNAME')
		password: os.getenv('DB_PASSWORD')
		dbname: os.getenv('DB_NAME')
		port: os.getenv('DB_PORT').u32()
		host: os.getenv('DB_HOST')
	}

	time.sleep(3 * time.second)
	
	db.connect()!

	db.select_db('todos')!
	
	return db
}
