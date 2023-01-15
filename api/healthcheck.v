module api

import mikan-sour.mikanvex.ctx

import time

struct Healthcheck {
	ok bool
	time time.Time
}

pub fn healthcheck(req &ctx.Req, mut res ctx.Resp){

	response := Healthcheck {
		ok:true,
		time: time.now()
	}
	
	res.send_json<Healthcheck>(response,200)
}
