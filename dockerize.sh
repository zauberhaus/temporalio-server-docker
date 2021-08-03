#/bin/sh

git clone https://github.com/jwilder/dockerize.git dockerize
cd dockerize
go mod init github.com/jwilder/dockerize
go mod tidy
CGO_ENABLED=0 go build -o ../dist/dockerize_amd64 
CGO_ENABLED=0 GOARCH=arm64 go build -o ../dist/dockerize_arm64 
CGO_ENABLED=0 GOARCH=ppc64le go build -o ../dist/dockerize_ppc64le 
CGO_ENABLED=0 GOARCH=s390x go build -o ../dist/dockerize_s390x 


