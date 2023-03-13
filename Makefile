DOCKER_ACCOUNT = vsvegner

PWD := $(shell pwd)
PROJECTNAME = $(shell basename $(PWD))
PROGRAM_NAME = $(shell basename $(PWD))

VERSION=$(shell git describe --tags)
COMMIT=$(shell git rev-parse --short HEAD)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
TAG=$(shell git describe --tags |cut -d- -f1)
BUILD_TIME?=$(shell date -u '+%Y-%m-%d_%H:%M:%S')

# Check for required command tools to build or stop immediately
EXECUTABLES = git find pwd basename
	K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH)))

.PHONY: help dep build run

.DEFAULT_GOAL := help

help: ## Display this help screen.
	@echo "Makefile available targets:"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  * \033[36m%-15s\033[0m %s\n", $$1, $$2}'


dep: ## Download the dependencies.
	pip install -r requirements.txt

build: ## Build Docker from Dockerfile
	docker build -t ${DOCKER_ACCOUNT}/${PROJECTNAME}:${VERSION} .

run: ## Run Docker container
	docker run --env-file ${PWD}/dev.env -v ${PWD}/saved.session:/app/saved.session ${DOCKER_ACCOUNT}/${PROJECTNAME}:latest

daemon: ## Run Docker container
	docker run --restart=on-failure:20 -d --env-file ${PWD}/dev.env -v ${PWD}/saved.session:/app/saved.session ${DOCKER_ACCOUNT}/${PROJECTNAME}:latest

first_run: ## Run Docker container
	docker run -i --env-file ${PWD}/dev.env -v ${PWD}/saved.session:/app/saved.session ${DOCKER_ACCOUNT}/${PROJECTNAME}:latest

push: ## Pash Docker Image to hub.docker.com
	docker tag ${DOCKER_ACCOUNT}/${PROJECTNAME}:${VERSION} ${DOCKER_ACCOUNT}/${PROJECTNAME}:${VERSION}
	docker push ${DOCKER_ACCOUNT}/${PROJECTNAME}:${VERSION}
	docker tag ${DOCKER_ACCOUNT}/${PROJECTNAME}:${VERSION} ${DOCKER_ACCOUNT}/${PROJECTNAME}:latest
	docker push ${DOCKER_ACCOUNT}/${PROJECTNAME}:latest