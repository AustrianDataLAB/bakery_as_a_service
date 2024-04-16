SHELL := /usr/bin/env bash

IMAGE_NAME_BACKEND := baas_strapi

.PHONY:
up:
	docker-compose up -d --remove-orphans

.PHONY:
test:
	docker-compose -f docker-compose.yml run backend-test # frontend-test...

.PHONY:
down:
	docker-compose down --remove-orphans

.PHONY:
rmi:
	docker rmi $(IMAGE_NAME_BACKEND) 
