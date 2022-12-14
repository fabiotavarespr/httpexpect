GO111MODULE := on
export GO111MODULE

all: build lint test

build:
	go build
	cd _examples && go build

lint:
	golangci-lint run .

test:
	go test
	cd _examples && go test

fmt:
	gofmt -s -w . ./_examples

tidy:
	go mod tidy -v
	mv _examples examples && ( \
		cd examples ; \
		go mod tidy -v ; \
		go get -v -u=patch github.com/fabiotavarespr/httpexpect ; \
			) && mv examples _examples
