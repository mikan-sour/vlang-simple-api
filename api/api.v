module api

import vweb
import mysql

import service

[heap]
struct App {
	vweb.Context
pub mut: 
	db 			 mysql.Connection
	healthcheck_service &service.HealthcheckServiceImpl = &service.HealthcheckServiceImpl{}
	todo_service &service.TodoServiceImpl = &service.TodoServiceImpl{}
}

pub fn new_api(db mysql.Connection) &App {
	return &App{
		db:db,
		healthcheck_service: service.new_healthcheck_service()
		todo_service:service.new_todo_service()
	}
}

// a middleware
pub fn (mut app App) before_request() {
	log_line := "/$app.req.method $app.req.url"
    println(log_line.capitalize())
}