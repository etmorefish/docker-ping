FROM golang:1.20.1 AS builder

# 为我们的镜像设置必要的环境变量
ENV GO111MODULE=on \
    GOPROXY=goproxy.io \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app

COPY . .
RUN go mod download

RUN go build -o docker-ping

# FROM debian:buster-slim 
# FROM alpine:latest  
FROM scratch 

COPY --from=builder /app/docker-ping /
# USER nonroot:nonroot
EXPOSE 8080
CMD ["/app/docker-ping"]