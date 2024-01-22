package service

import (
	"fmt"
	"github.com/improbable-eng/grpc-web/go/grpcweb"
	"google.golang.org/grpc"
	"log"
	"net"
	"net/http"
	"sync"
)

func NewGrpcServer(service, host string, grpcServer *grpc.Server, wg *sync.WaitGroup) {
	defer wg.Done()
	listener, err := net.Listen("tcp", host)
	if err != nil {
		log.Fatalf("failed to listen on %s, %s\n", host, err)
	}
	fmt.Printf("%s grpc serving on %s\n", service, host)
	err = grpcServer.Serve(listener)
	if err != nil {
		log.Fatalf("%s failed to serve on %s, %s\n", service, host, err)
	}
}

func NewWebServer(service, host string, grpcServer *grpc.Server, wg *sync.WaitGroup) {
	defer wg.Done()
	grpcWebServer := grpcweb.WrapServer(
		grpcServer,
		grpcweb.WithOriginFunc(func(origin string) bool { return true }), // Enable CORS
	)
	srv := &http.Server{
		Handler: grpcWebServer,
		Addr:    host,
	}
	fmt.Printf("%s http serving on %s\n", service, srv.Addr)
	if err := srv.ListenAndServe(); err != nil {
		log.Fatalf("%s failed to serve http on %s, %s\n", service, host, err)
	}
}
