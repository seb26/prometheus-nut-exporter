VERSION ?= v1.2.1-seb26-0.2.0
PLATFORM ?= linux/amd64
REGISTRY ?= 
IMAGE_NAME ?= $(if $(REGISTRY),$(REGISTRY)/,)hon95/prometheus-nut-exporter:$(VERSION)

build:
	docker buildx build \
		. \
		--target builder \
		--build-arg APP_VERSION=$(VERSION) \
		--platform $(PLATFORM) \
		-t builder-local \
		--load

build-image:
	docker buildx build \
		. \
		--build-arg APP_VERSION=$(VERSION) \
		--platform $(PLATFORM) \
		-t $(IMAGE_NAME) \
		--load

check:
	manage/check.sh
	manage/integration_test.sh

push:
	docker push $(IMAGE_NAME)