FROM golang:alpine as builder

WORKDIR /usr/build
ADD main.go .
COPY go.mod .
COPY go.sum .

RUN go mod download
RUN go build -o app .

FROM alpine:latest

WORKDIR /usr/src
COPY --from=builder /usr/build/app .
EXPOSE 8080
CMD ["/usr/src/app"]