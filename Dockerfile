FROM golang:1.17.4-alpine3.15

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
ENV GOOGLE_APPLICATION_CREDENTIALS=/go/src/app/mfe_deploy.json

CMD ["gcsproxy", "-v", "-b", ":8080", "-bn", "rosetta-mfe-test"]

