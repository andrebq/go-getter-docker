FROM golang:1.13.7-alpine@sha256:9817fae0190681da743ae2f5f77a85bf19b2e759d655bc427328e075b8d64dcc as builder

RUN apk add git
RUN mkdir -p /opt/go-getter/src && mkdir -p /opt/go-getter/bin
WORKDIR /opt/go-getter/src

# 0d2e82b049447fff51421fcfb85ee25016d2ced1 -> v1.4.1
RUN git init . && \
    git remote add origin https://github.com/hashicorp/go-getter && \
    git fetch --depth 1 origin 0d2e82b049447fff51421fcfb85ee25016d2ced1 && \
    git reset --hard 0d2e82b049447fff51421fcfb85ee25016d2ced1

ENV CGO_ENABLED=0
RUN go build -o /opt/go-getter/bin/go-getter ./cmd/go-getter

FROM scratch
COPY --from=builder /opt/go-getter/bin/go-getter /go-getter
