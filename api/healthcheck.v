module api

import vweb

['/api/health';get]
pub fn (mut app App) healthcheck() vweb.Result{

	healthcheck := app.healthcheck_service.healthcheck(mut app.db)
	
	return app.json(healthcheck)
}
