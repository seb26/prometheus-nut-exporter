VERSION ?= v1.2.1-seb26-0.1.0
PLATFORM ?= linux/amd64
IMAGE_NAME ?= hon95/prometheus-nut-exporter:$(VERSION)
REGISTRY ?= 

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
	skopeo copy docker-daemon:$(IMAGE_NAME) docker://$(REGISTRY)/$(IMAGE_NAME)