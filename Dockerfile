FROM golang:alpine3.18 AS Build

WORKDIR /www/go

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o main main.go

FROM scratch

WORKDIR /www/go

COPY --from=Build /www/go/main .

ENTRYPOINT [ "./main" ]