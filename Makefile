.PHONY: build release check

build: check
	docker build -t andrebq/go-getter .

check:
	docker run --rm -t -w /src -v ${PWD}:/src koalaman/shellcheck ./ci/linux/*.sh

release: build
	bash -x ci/linux/dockerPush.sh
