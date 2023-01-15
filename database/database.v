module database

import mysql
import time

import mikan-sour.mikanvex.ctx

pub const db_ctx_key = 'db'

pub fn get_db(req &ctx.Req) ?&mysql.Connection {
	raw_db := req.ctx.value(db_ctx_key) ?
	if raw_db is mysql.Connection {
		return raw_db
	}
	return none
}

pub fn db_init() !mysql.Connection {
	mut db := mysql.Connection{
		username: 'mysql'
		password: 'mysql'
		dbname: 'todos'
		port: 3306
		host: 'db'
	}

	time.sleep(3 * time.second)
	db.connect()!
	
	db.select_db('todos')!
	
	return db
}

