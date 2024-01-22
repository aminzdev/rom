package service

import (
	"RomA-T.Server/request"
	"context"
	"fmt"
	"github.com/google/uuid"
	"google.golang.org/grpc"
	"google.golang.org/grpc/grpclog"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/peer"
)

func ipFromContext(ctx context.Context) (string, error) {
	p, ok := peer.FromContext(ctx)
	if !ok {
		return "", fmt.Errorf("could not get client IP address")
	}
	return p.Addr.String(), nil
}

func RecordRequests(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, fmt.Errorf("could not get incoming context metadata")
	}

	var user string
	var accessToken string

	if value := md.Get("user"); len(value) != 0 {
		user = value[0]
	}
	//if user == "" {
	//	switch info.FullMethod {
	//	case "/protocol.Auth/Login":
	//		user = req.(*protocol.LoginReq).Name
	//	case "/protocol.Auth/RegisterUser":
	//		switch req := req.(*protocol.RegisterUserReq).Options.(type) {
	//		case *protocol.RegisterUserReq_User_:
	//			user = req.User.Name
	//		case *protocol.RegisterUserReq_Verification_:
	//			user = req.Verification.Name
	//		}
	//	}
	//}
	if value := md.Get("access-token"); len(value) != 0 {
		accessToken = value[0]
	}

	ip, err := ipFromContext(ctx)
	if err != nil {
		return nil, err
	}

	reqID := uuid.NewString()
	grpclog.Infof("[user: %s] [ip: %s] [called: %s] request=%s", user, ip, info.FullMethod, reqID)

	ctx = context.WithValue(ctx, "request", &request.Request{
		ID:          reqID,
		User:        user,
		IPAddress:   ip,
		AccessToken: accessToken,
	})

	h, err := handler(ctx, req)
	return h, err
}
