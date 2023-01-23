module main

import os
import vweb

import zztkm.vdotenv

import api 
import database

fn main() {

    vdotenv.load()

    database_instance := database.db_init()!

 	mut app := api.new_api(database_instance)

    vweb.run(app, os.getenv("APP_PORT").int())
}