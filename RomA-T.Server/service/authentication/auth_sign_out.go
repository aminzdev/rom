package authentication

import (
	"RomA-T.Server/protocol"
	"RomA-T.Server/request"
	"context"
	"fmt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *Server) SignOut(ctx context.Context, req *protocol.SignOutReq) (*protocol.SignOutRes, error) {
	reqx := request.FromContext(ctx)

	if len(req.User) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("name is empty"))
	}

	user, err := s.memory.FindUserByName(ctx, req.User)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "user %s not found", req.User)
	}

	user.Session.Token = ""

	err = s.memory.UpdateUser(ctx, user)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "could not update user's session", err.Error(), req.User)
	}

	s.log.Info().Str("request", reqx.ID).Msgf("user '%s' signed out", req.User)
	return &protocol.SignOutRes{}, nil
}
