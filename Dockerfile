FROM golang:alpine AS builder
WORKDIR /app
RUN apk add --no-cache git
RUN git clone https://github.com/path-network/go-mmproxy .
RUN go mod tidy
RUN go build -o mmproxy .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/mmproxy .
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
ENTRYPOINT ["/app/start.sh"]
