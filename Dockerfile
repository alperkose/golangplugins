ARG GO_VERSION=1.11

FROM golang:${GO_VERSION} as simpleuser
ADD . /go/src/github.com/alperkose/golangplugins
WORKDIR /go/src/github.com/alperkose/golangplugins/simpleuser
RUN go build -o /simpleuser.plugin -buildmode=plugin .

FROM golang:${GO_VERSION} as vendoreduser
ADD . /go/src/github.com/alperkose/golangplugins
WORKDIR /go/src/github.com/alperkose/golangplugins/vendoreduser
# Simulating a shared packaged that is used by plugin from vendors folder
RUN mkdir -p vendor/github.com/alperkose/golangplugins && \
    cp -r ../user vendor/github.com/alperkose/golangplugins/ && \
    go build -o /vendoreduser.plugin -buildmode=plugin .

FROM golang:${GO_VERSION} as differentgopath
ENV GOPATH /mnt/
ADD . /mnt/src/github.com/alperkose/golangplugins
WORKDIR /mnt/src/github.com/alperkose/golangplugins/simpleuser
RUN go build -o /differentgopath.plugin -buildmode=plugin .

FROM golang:${GO_VERSION}
ADD . /go/src/github.com/alperkose/golangplugins
WORKDIR /go/src/github.com/alperkose/golangplugins
RUN go build -o main .
COPY --from=simpleuser simpleuser.plugin .
COPY --from=vendoreduser vendoreduser.plugin .
COPY --from=differentgopath differentgopath.plugin .
ENTRYPOINT [ "./main" ]