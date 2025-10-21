SHELL = /bin/bash

.PHONY: default help test test-only docker-build bash

TARGET_STAGE ?= develop

default: test

help:
	@echo -e "==== Makefile helper ====\n"
	@echo "- Use 'make test' (default) to run all tests and generate a coverage html report"
	@echo "- Use 'make test-only' to only run all tests"
	@echo "- Use 'make docker-build' to generate the docker image"
	@echo "- Use 'make bash' to enter into a bash terminal whatinside the running container"

test-only:
	@if [ -z "$$VIRTUAL_ENV" ]; then \
		echo "Not in env. Run 'source .venv/bin/activate'"; \
		echo "For detailed instructions check 'make help' and the README"; \
		exit 1; \
	else \
	 	DJANGO_SETTINGS_MODULE=devopsdemo.settings \
		python -m coverage run -m pytest; \
	fi

test: test-only
	@python -m coverage report -m
	@python -m coverage html
	@echo -e "Check: " $(shell pwd)"/htmlcov/index.html"

docker-build:
	docker build --target $(TARGET_STAGE) .

bash:
	docker exec -it $(TAG) bash

