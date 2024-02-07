# We use Bash syntax
SHELL := $(shell which bash)

# Update this
APP_ORG := chybz.net
APP_NAME := caddy
APP_VER := 0.1

TOPDIR := $(shell pwd)

###############################################################################
#
# Help Section
#
###############################################################################
define help_header

Usage: make [TARGET]

Targets:
endef
export help_header

.PHONY: all help clean lint test
.SECONDEXPANSION:

###############################################################################
#
# Development targets
#
###############################################################################
all: docker-image
	@echo "all packages ready"

help:
	@echo "$$help_header"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -En 's/^(.*): (.*)##(.*)/  \1=\3/p' \
	| column -t  -s '='

docker-image: ## Builds Docker image
	docker \
	    build \
	    -t $(APP_ORG):$(APP_NAME)-$(APP_VER) \
	    --progress plain \
	    . 2>&1 | tee docker.log

###############################################################################
#
# Maintenance targets
#
###############################################################################
clean: clean-logs ## Cleans everything

clean-logs: ## Cleans log files
	rm -rf *.log
