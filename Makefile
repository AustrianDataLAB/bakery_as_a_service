SHELL := /usr/bin/env bash

.PHONY:
up:
	docker-compose up -d --remove-orphans

.PHONY:
test:
	docker-compose -f docker-compose.yml run backend-test frontend-test

.PHONY:
down:
	docker-compose down --remove-orphans
