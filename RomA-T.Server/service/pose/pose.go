package pose

import (
	"RomA-T.Server/auth/token"
	"RomA-T.Server/protocol"
	"RomA-T.Server/service"
	"github.com/rs/zerolog"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"io"
	"log"
	"math"
	"sync"
	"time"
)

type Server struct {
	protocol.UnimplementedPoseServer
	log             zerolog.Logger
	pyposePath      string
	uploadDir       string
	pyposeOutputDir string
	tokenMaker      token.Maker
}

func RunServer(
	grpcHost, grpcWebHost string,
	logger io.Writer,
	pyposePath, uploadDir, pyposeOutputDir string,
	SymmetricKey string,
) {
	maker, err := token.NewPaseto(SymmetricKey)
	if err != nil {
		log.Fatalf("could not create token maker, %v", err)
	}

	server := &Server{
		pyposePath:      pyposePath,
		uploadDir:       uploadDir,
		pyposeOutputDir: pyposeOutputDir,
		tokenMaker:      maker,
		log: zerolog.New(zerolog.ConsoleWriter{Out: logger, TimeFormat: time.DateTime, NoColor: true}).
			With().Timestamp().Str("service", "pose").Logger(),
	}
	maxMsgSize := int(math.Pow(2, 27)) // 128MB
	grpcServer := grpc.NewServer(
		grpc.MaxRecvMsgSize(maxMsgSize),
		grpc.MaxSendMsgSize(maxMsgSize),
		grpc.ChainUnaryInterceptor(
			service.RecordRequests,
		),
	)
	protocol.RegisterPoseServer(grpcServer, server)
	reflection.Register(grpcServer)

	serviceName := "pose"

	wg := &sync.WaitGroup{}
	if grpcHost != "" {
		wg.Add(1)
		go service.NewGrpcServer(serviceName, grpcHost, grpcServer, wg)
	}
	if grpcWebHost != "" {
		wg.Add(1)
		go service.NewWebServer(serviceName, grpcWebHost, grpcServer, wg)
	}
	wg.Wait()
}
