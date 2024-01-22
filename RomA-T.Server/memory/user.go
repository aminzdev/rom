package memory

import (
	"RomA-T.Server/model"
	"RomA-T.Server/request"
	"context"
	"github.com/jackc/pgx/v5/pgconn"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func (m *Memory) CreateUser(ctx context.Context, user *model.User) error {
	reqx := request.FromContext(ctx)

	res := m.db.Create(&user)
	if res.Error != nil {
		if res.Error.(*pgconn.PgError).Message == "duplicate key value violates unique constraint \"users_name_key\"" {
			return NewError(AlreadyExists, "user already exists")
		} else {
			m.log.Error(res.Error, reqx.ID)
			return NewError(Internal, "could not create user")
		}
	}

	return nil
}

func (m *Memory) FindUserByName(ctx context.Context, name string) (*model.User, error) {
	reqx := request.FromContext(ctx)

	var user *model.User
	res := m.db.Preload("Session").First(&user, "name = ?", name)
	if res.Error != nil {
		switch res.Error {
		case gorm.ErrRecordNotFound:
			return nil, NewError(ErrNotFound, "user not found")
		default:
			m.log.Error(res.Error, reqx.ID)
			return nil, NewError(Internal, "could not find user")
		}
	}

	return user, nil
}

func (m *Memory) UpdateUser(ctx context.Context, user *model.User) error {
	reqx := request.FromContext(ctx)

	res := m.db.
		Session(&gorm.Session{FullSaveAssociations: true}).
		Updates(&user)
	if res.Error != nil {
		m.log.Error(res.Error, reqx.ID)
		return NewError(Internal, "could not update user")
	}

	return nil
}

func (m *Memory) RemoveUser(ctx context.Context, user *model.User) error {
	reqx := request.FromContext(ctx)

	res := m.db.
		Unscoped().
		Select(clause.Associations).
		Delete(&user)
	if res.Error != nil {
		m.log.Error(res.Error, reqx.ID)
		return NewError(Internal, "could not remove user")
	}

	return nil
}
