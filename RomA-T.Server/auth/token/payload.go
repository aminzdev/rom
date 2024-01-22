package token

import (
	"errors"
	"github.com/google/uuid"
	"time"
)

var (
	InvalidTokenError = errors.New("access-token is invalid")
	ExpiredTokenError = errors.New("access-token has expired")
)

type Payload struct {
	ID        uuid.UUID
	User      string
	CreatedAt time.Time
	ExpiredAt time.Time
}

func (p *Payload) Valid() error {
	if time.Now().After(p.ExpiredAt) {
		return ExpiredTokenError
	}
	return nil
}

func NewPayload(user string, duration time.Duration) (*Payload, error) {
	tokenID, err := uuid.NewRandom()
	if err != nil {
		return nil, err
	}

	payload := &Payload{
		ID:        tokenID,
		User:      user,
		CreatedAt: time.Now(),
		ExpiredAt: time.Now().Add(duration),
	}
	return payload, nil
}
