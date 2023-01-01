module api

import nedpals.vex.ctx

interface Api {
	healthcheck(req &ctx.Req, mut res ctx.Resp)
}

struct ApiImpl {

}

// pub fn new_api() Api {
// 	return ApiImpl{}
// }
