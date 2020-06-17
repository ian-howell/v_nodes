IMAGE_REGISTRY=port
IMAGE_TAG=latest

.PHONY: help

SHELL:=/bin/bash
.ONESHELL:

help: ## This help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## Build the containers.
	docker build --tag $(IMAGE_REGISTRY)/libvirt:$(IMAGE_TAG) ./libvirt
	docker build --tag $(IMAGE_REGISTRY)/sushy:$(IMAGE_TAG) ./sushy
	docker build --tag $(IMAGE_REGISTRY)/virsh:$(IMAGE_TAG) ./virsh

push: build ## Build and push the containers
	docker push $(IMAGE_REGISTRY)/libvirt:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/sushy:$(IMAGE_TAG)
	docker push $(IMAGE_REGISTRY)/virsh:$(IMAGE_TAG)

test: push ## Test vairship-pod
	kubectl delete -f libvirt.yaml || true
	kubectl create -f libvirt.yaml