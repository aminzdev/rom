package pose

import (
	"RomA-T.Server/protocol"
	"context"
)

func (s *Server) Ping(ctx context.Context, req *protocol.PingReq) (*protocol.PingRes, error) {
	return &protocol.PingRes{}, nil
}
