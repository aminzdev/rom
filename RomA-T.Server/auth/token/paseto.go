package token

import (
	"fmt"
	"github.com/aead/chacha20poly1305"
	"github.com/o1egl/paseto"
	"log"
	"time"
)

type Paseto struct {
	paseto       *paseto.V2
	symmetricKey []byte
}

func (p *Paseto) CreateToken(user string, duration time.Duration) (string, error) {
	payload, err := NewPayload(user, duration)
	if err != nil {
		return "", err
	}

	encrypt, err := p.paseto.Encrypt(p.symmetricKey, payload, nil)
	if err != nil {
		return "", err
	}

	return encrypt, nil
}

func (p *Paseto) VerifyToken(token string) (*Payload, error) {
	payload := &Payload{}

	err := p.paseto.Decrypt(token, p.symmetricKey, payload, nil)
	if err != nil {
		log.Printf("%s, %v\n", InvalidTokenError, err)
		return nil, InvalidTokenError
	}

	err = payload.Valid()
	if err != nil {
		return nil, err
	}

	return payload, nil
}

func NewPaseto(symmetricKey string) (Maker, error) {
	if len(symmetricKey) != chacha20poly1305.KeySize {
		return nil, fmt.Errorf("invalid key size, must be exactly %d characters", chacha20poly1305.KeySize)
	}

	maker := &Paseto{
		paseto:       paseto.NewV2(),
		symmetricKey: []byte(symmetricKey),
	}

	return maker, nil
}
