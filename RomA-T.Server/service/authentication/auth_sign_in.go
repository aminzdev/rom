package authentication

import (
	"RomA-T.Server/model"
	"RomA-T.Server/protocol"
	"context"
	"fmt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"time"
)

func (s *Server) SignIn(ctx context.Context, req *protocol.SignInReq) (*protocol.SignInRes, error) {
	if len(req.User.Name) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("name is empty"))
	}
	if len(req.User.Code) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("code is empty"))
	}

	user := &model.User{
		Name: req.User.Name,
		Code: req.User.Code,
	}
	err := user.Validate()
	if err != nil {
		return nil, status.Error(codes.InvalidArgument, "invalid user")
	}

	tokenValidTime := time.Minute * 30
	_token, err := s.auth.Login(ctx, user.Name, user.Code, tokenValidTime)
	if err != nil {
		return nil, err
	}

	return &protocol.SignInRes{Token: _token}, nil
}
