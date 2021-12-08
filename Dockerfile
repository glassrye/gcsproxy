#FROM alpine:3.7
#ENV GCSPROXY_VERSION=0.3.0
#RUN apk add --update ca-certificates
#RUN apk add --no-cache --virtual .build-deps ca-certificates wget \
  #&& wget https://github.com/daichirata/gcsproxy/releases/download/v${GCSPROXY_VERSION}/gcsproxy_${GCSPROXY_VERSION}_amd64_linux -O /usr/local/bin/gcsproxy \
  #&& chmod +x /usr/local/bin/gcsproxy \
  #&& apk del .build-deps
FROM golang:1.17.4-alpine3.15

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
ENV GOOGLE_APPLICATION_CREDENTIALS=/go/src/app/mfe_deploy.json

CMD ["gcsproxy", "-v", "-b", ":8080", "-bn", "rosetta-mfe-test"]

