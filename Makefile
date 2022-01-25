TAG=$(shell git describe --abbrev=0 --tags)
REGISTRY=ubuntool
PROVIDER=ghcr.io/tolson-vkn
MAKE_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: help
help:
	@echo "+------------------+"
	@echo "| ubuntool targets |"
	@echo "+------------------+"
	@grep -E '^[a-zA-Z\-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build ubuntool locally

	podman build -t ubuntool .

.PHONY: shell
shell: ## Start a /bin/bash shell on ubuntool container

	podman run --rm -i -t ubuntool bash

.PHONY: login
login: ## Login to Github
	@echo "Login to Github."
	podman login $(PROVIDER)/$(REGISTRY)

.PHONY: publish
publish: ## Build locally and publish to registry

	# Do this first
	# git tag -a v1.1.0 a8cdab287c4f13d05c5bb5fa69a7879b166445ac
	# git push origin v1.1.0

	@make build
	@make login
	@printf '\033[33mBuild and Push ubuntool\033[0m\n';
	podman build -t ubuntool:$(TAG) .
	podman tag ubuntool:$(TAG) $(PROVIDER)/$(REGISTRY):$(TAG)
	podman push $(PROVIDER)/$(REGISTRY):$(TAG)

	@printf '\033[33mUpdate the latest tag to $(TAG)\033[0m\n';
	podman tag ubuntool:$(TAG) $(PROVIDER)/$(REGISTRY):latest
	podman push $(PROVIDER)/$(REGISTRY):latest
