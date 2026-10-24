DOCKER_IMAGE=dockette/varnish
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64
VERSION:=$(shell cat VERSION)

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

.PHONY: test
test:
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} varnishd -V
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} test -x /entrypoint.sh
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} test -f /etc/varnish/default.vcl
	docker run --rm --add-host app:127.0.0.1 ${DOCKER_IMAGE}:${DOCKER_TAG} varnishd -C -f /etc/varnish/default.vcl

.PHONY: run
run:
	docker network create varnish-run >/dev/null 2>&1 || true
	docker run --rm -d --name varnish-app --network varnish-run --network-alias app nginx:alpine
	docker run --rm -it -p 80:80 --network varnish-run ${DOCKER_IMAGE}:${DOCKER_TAG}; status=$$?; docker stop varnish-app >/dev/null; exit $$status

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@date -u +%Y.%m.%d > VERSION
	@echo "VERSION: ${VERSION} -> $$(cat VERSION)"
	@echo "next: git commit -am \"Release: $$(cat VERSION)\" && git push"
