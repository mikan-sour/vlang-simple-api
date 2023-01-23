module service

import mysql
import time

pub struct Healthcheck {
	ok bool
	time time.Time
}

pub interface HealthcheckService{
mut:
	healthcheck(db mysql.Connection)Healthcheck
}

[heap]
pub struct HealthcheckServiceImpl {}

pub fn new_healthcheck_service() &HealthcheckServiceImpl {
	return &HealthcheckServiceImpl{}
}

pub fn (hcs &HealthcheckServiceImpl) healthcheck(mut db mysql.Connection) Healthcheck {
	return Healthcheck{
		ok: db.ping() or {false},
		time: time.now()
	}
}

