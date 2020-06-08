TAG=$(shell git log --pretty=format:'%h' -n 1)
REGISTRY=timmyolson/ubuntool
PROVIDER=docker.io
MAKE_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: help
help:
	@echo "+------------------+"
	@echo "| ubuntool targets |"
	@echo "+------------------+"
	@grep -E '^[a-zA-Z\-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build ubuntool locally

	docker build -t ubuntool .

.PHONY: shell
shell: ## Start a /bin/bash shell on ubuntool container

	docker run --rm -i -t ubuntool bash

.PHONY: publish
publish: ## Build locally and publish to registry

	@printf '\033[33mBuild and Push ubuntool\033[0m\n';
	docker build -t ubuntool:$(TAG) .
	docker tag ubuntool:$(TAG) $(REGISTRY):$(TAG)
	docker push $(REGISTRY):$(TAG)

	@printf '\033[33mUpdate the latest tag to $(TAG)\033[0m\n';
	docker tag ubuntool:$(TAG) $(REGISTRY):latest
	docker push $(REGISTRY):latest
