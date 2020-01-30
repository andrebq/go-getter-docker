.PHONY: build release

build:
	docker build -t andrebq/go-getter .

release: build
	bash -x ci/linux/dockerPush.sh
