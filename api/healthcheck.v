module api

import vweb

import service
import utils

['/api/health';get]
pub fn (mut app App) healthcheck() vweb.Result{

	healthcheck := app.healthcheck_service.healthcheck(mut app.db)
	
	return app.json(utils.response[service.Healthcheck](true, healthcheck))
}
