package config

import (
	"github.com/go-playground/validator/v10"
)

type PoseServiceConfig struct {
	GrpcHost        string `mapstructure:"grpc-host"`
	GrpcWebHost     string `mapstructure:"grpc-web-host"`
	PyposeService   string `mapstructure:"pypose-service"`
	UploadDir       string `mapstructure:"upload-dir"`
	PyposeOutputDir string `mapstructure:"pypose-output-dir"`
	SymmetricKey    string `mapstructure:"symmetric-key"`
}

func (s *PoseServiceConfig) Validate() error {
	return validator.New().Struct(s)
}
