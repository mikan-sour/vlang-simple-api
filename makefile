down:
	@docker-compose down -v

up:
	export DOCKER_CLIENT_TIMEOUT=120
	export COMPOSE_HTTP_TIMEOUT=120
	@docker-compose build
	@docker-compose up 

env:
	cp ./.env.sample ./.env

run:
	brew services stop postgresql@14
	brew services start postgresql@14
	v -enable-globals run main.v