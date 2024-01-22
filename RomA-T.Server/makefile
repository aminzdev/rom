protocol:
	protoc proto/*.proto -I proto/ --go_out=. --go-grpc_out=. --dart_out=grpc:../RomA-T.UI/RoMA-T/lib/service/protocols/

servers: pose-server auth-server

pose-server:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o build/pose/pose.server server/pose/server.go ;
	cp configurations/pose.config.yaml build/pose/

auth-server:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o build/auth/auth.server server/auth/server.go ;
	cp configurations/auth.config.yaml build/auth/

.PHONY: protocol servers
