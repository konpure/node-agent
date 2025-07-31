TAG ?= $(shell git describe --tags --always)
ORG ?= keyval
BUILD_ARGS ?=

.PHONY: clean
clean:
	rm -rf dist

.PHONY: build
build: clean
	mkdir -p dist
	go build -o dist/node-agent

.PHONY: package
package: build
	tar -czf dist/node-agent.tar.gz dist/node-agent

.PHONY: docker-build
docker-build: package
    docker build -f ./docker/Dockerfile -t $(ORG)/apo-node-agent:$(TAG) .