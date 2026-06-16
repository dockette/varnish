DOCKER_IMAGE=dockette/varnish
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

.PHONY: test
test:
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} varnishd -V
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} test -x /entrypoint.sh
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} test -f /etc/varnish/default.vcl
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} varnishd -C -f /etc/varnish/default.vcl

.PHONY: run
run:
	docker network create varnish-run >/dev/null 2>&1 || true
	docker run --rm -d --name varnish-app --network varnish-run --network-alias app nginx:alpine
	docker run --rm -it -p 80:80 --network varnish-run ${DOCKER_IMAGE}:${DOCKER_TAG}; status=$$?; docker stop varnish-app >/dev/null; exit $$status
