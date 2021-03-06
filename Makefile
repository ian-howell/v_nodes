# APP INFO
BUILD_DIR         := $(shell mktemp -d)
IMAGE_REGISTRY    ?= ianhowell
IMAGE_NAME        ?= base,infra-builder,libvirt,sushy,airshipctl-builder,runner
IMAGE_TAG         ?= test
HELM              ?= $(BUILD_DIR)/helm
PROXY             ?= http://proxy.foo.com:8000
NO_PROXY          ?= localhost,127.0.0.1,.svc.cluster.local
USE_PROXY         ?= false
PUSH_IMAGE        ?= false
# use this variable for image labels added in internal build process
LABEL             ?= org.airshipit.build=community
COMMIT            ?= $(shell git rev-parse HEAD)
PYTHON            = python3
CHARTS            := $(patsubst charts/%/.,%,$(wildcard charts/*/.))
DISTRO            ?= ubuntu_bionic
IMAGE             := ${DOCKER_REGISTRY}/${IMAGE_PREFIX}/${IMAGE_NAME}:${IMAGE_TAG}-${DISTRO}
USE_CACHE         ?= false

.PHONY: help

SHELL:=/bin/bash
.ONESHELL:

help: ## This help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## Build the containers.
	docker build --tag $(IMAGE_REGISTRY)/base:$(IMAGE_TAG) --build-arg BASE_IMAGE=ubuntu:20.04 ./base
	docker build --tag $(IMAGE_REGISTRY)/libvirt:$(IMAGE_TAG) ./libvirt
	docker build --tag $(IMAGE_REGISTRY)/sushy:$(IMAGE_TAG) ./sushy
	docker build --tag $(IMAGE_REGISTRY)/infra-builder:$(IMAGE_TAG) ./infra-builder
	docker build --tag $(IMAGE_REGISTRY)/airshipctl-builder:$(IMAGE_TAG) ./airshipctl-builder
	docker build --tag $(IMAGE_REGISTRY)/runner:$(IMAGE_TAG) ./runner

push: build ## Build and push the containers
	docker push $(IMAGE_REGISTRY)/base:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/libvirt:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/sushy:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/infra-builder:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/airshipctl-builder:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/runner:$(IMAGE_TAG)

test-with-cache: USE_CACHE = true
test-with-cache: test

test: push ## Test vairship-pod
	kubectl delete -f vairship.yaml || true
	kubectl create -f vairship.yaml
