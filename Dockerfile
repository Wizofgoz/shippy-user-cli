FROM golang:1.12-alpine as builder

WORKDIR /go/src/github.com/wizofgoz/shippy-user-cli

RUN apk add --no-cache git

COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/wizofgoz/shippy-user-cli .

ENTRYPOINT ["./shippy-user-cli"]

CMD ["./shippy-user-cli"]