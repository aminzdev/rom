package config

import (
	"RomA-T.Server/memory"
	"github.com/go-playground/validator/v10"
)

type AuthServiceConfig struct {
	GrpcHost     string `mapstructure:"grpc-host"`
	GrpcWebHost  string `mapstructure:"grpc-web-host"`
	SymmetricKey string `mapstructure:"symmetric-key"`
	LogFile      string `validate:"omitempty,filepath" mapstructure:"log-file"`
	Postgres     memory.Postgres
}

func (s *AuthServiceConfig) Validate() error {
	return validator.New().Struct(s)
}
