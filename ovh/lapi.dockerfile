

FROM golang:alpine as builder

RUN apk add --update rsyslog curl git openssh jq
RUN mkdir -p /go/src/github.com/lambdaspace/
RUN git clone https://github.com/lambdaspace/LambdaSpaceAPIv2 /go/src/github.com/lambdaspace/LambdaSpaceAPIv2
WORKDIR /go/src/github.com/lambdaspace/LambdaSpaceAPIv2

# Install dep
RUN curl -fsSL -o /usr/local/bin/dep $(curl -s https://api.github.com/repos/golang/dep/releases/latest | jq -r ".assets[] | select(.name | test(\"dep-linux-amd64\")) |.browser_download_url") && chmod +x /usr/local/bin/dep

# Build app
RUN dep ensure
RUN go build server.go

FROM alpine
RUN apk add --update ca-certificates
WORKDIR /bin
COPY --from=builder /go/src/github.com/lambdaspace/LambdaSpaceAPIv2/server .
COPY --from=builder /go/src/github.com/lambdaspace/LambdaSpaceAPIv2/LambdaSpaceAPI.json .
CMD [ "./server", "--env=development"]