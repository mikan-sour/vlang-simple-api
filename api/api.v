module api


import mikan-sour.mikanvex.ctx
import mikan-sour.mikanvex.router

interface Api {
	healthcheck(req &ctx.Req, mut res ctx.Resp)
}

[heap]
pub struct ApiImpl {
pub mut:
	router router.Router
}

pub fn new_api(router router.Router) ApiImpl {
	return ApiImpl{ router }
}
