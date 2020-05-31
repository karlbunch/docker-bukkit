
include version.mk

BUILDARGS=--squash --build-arg VERSION=$(VERSION)

build:
	docker build $(BUILDARGS) -t karlbunch/docker-bukkit:$(VERSION) .

build-nocache:
	docker build $(BUILDARGS) --no-cache -t karlbunch/docker-bukkit:$(VERSION) .
