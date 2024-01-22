package auth

import (
	"RomA-T.Server/memory"
	"RomA-T.Server/request"
	"context"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"time"
)

func (a *Auth) Login(ctx context.Context, name, code string, duration time.Duration) (string, error) {
	reqx := request.FromContext(ctx)

	user, err := a.memory.FindUserByName(ctx, name)
	if err != nil {
		a.log.UserNotFound(name, reqx.ID)

		switch err.(memory.Error).Code {
		case memory.ErrNotFound:
			return "", status.Error(codes.NotFound, "user not found")
		case memory.Internal:
			return "", status.Error(codes.Internal, "user not found")
		}
	}

	err = CheckCode(code, user.Code)
	if err != nil {
		a.log.InvalidCode(name, reqx.ID)
		return "", status.Error(codes.Unauthenticated, "invalid credentials")
	}

	_token, err := a.tokenMaker.CreateToken(user.Name, duration)
	if err != nil {
		a.log.FailedTokenCreation(user.Name, err, reqx.ID)
		return "", status.Error(codes.Internal, "could not create token")
	}

	user.Session.Token = _token
	err = a.memory.UpdateUser(ctx, user)
	if err != nil {
		a.log.UserSessionUpdateFailed(user.Name, reqx.ID)
		switch err.(memory.Error).Code {
		case memory.Internal:
			return "", status.Error(codes.Internal, "could not update user's session")
		}
	}
	a.log.UserLoggedIn(user.Name, reqx.ID)

	return _token, nil
}
