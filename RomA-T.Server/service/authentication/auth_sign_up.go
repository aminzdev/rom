package authentication

import (
	"RomA-T.Server/auth"
	"RomA-T.Server/memory"
	"RomA-T.Server/model"
	"RomA-T.Server/protocol"
	"RomA-T.Server/request"
	"context"
	"fmt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *Server) SignUp(ctx context.Context, req *protocol.SignUpReq) (*protocol.SignUpRes, error) {
	reqx := request.FromContext(ctx)

	if len(req.User.Name) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("name is empty"))
	}
	if len(req.User.Code) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("code is empty"))
	}

	hashCode, err := auth.HashCode(req.User.Code)
	if err != nil {
		s.log.Error().Str("request", reqx.ID).Err(err)
		return nil, status.Error(codes.Internal, "internal error, could not hash the user's code")
	}

	user := &model.User{
		Name: req.User.Name,
		Code: hashCode,
	}
	err = user.Validate()
	if err != nil {
		return nil, status.Error(codes.InvalidArgument, "invalid user")
	}

	err = s.memory.CreateUser(ctx, user)
	if err != nil {
		if err.(memory.Error).Code == memory.AlreadyExists {
			return nil, status.Error(codes.AlreadyExists, "user already exists")
		} else if err.(memory.Error).Code == memory.Internal {
			return nil, status.Error(codes.Internal, "internal error")
		}
	}

	s.log.Info().Str("request", reqx.ID).Msgf("user '%s' signed up", req.User.Name)
	return &protocol.SignUpRes{}, nil
}
