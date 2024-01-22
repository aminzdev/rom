package memory

import (
	"RomA-T.Server/model"
	"RomA-T.Server/request"
	"context"
	"errors"
)

func (m *Memory) CreateSession(ctx context.Context, session *model.Session) error {
	reqx := request.FromContext(ctx)

	res := m.db.Create(&session)

	if res.Error != nil {
		m.log.Error(res.Error, reqx.ID)
		return errors.New("could not create session, internal error")
	}

	return nil
}
