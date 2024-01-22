package main

import (
	"RomA-T.Server/config"
	"RomA-T.Server/service/pose"
	"github.com/spf13/viper"
	"log"
	"os"
	"os/signal"
	"syscall"
)

var serviceConfig config.PoseServiceConfig

func main() {
	logger := os.Stdout

	go pose.RunServer(
		serviceConfig.GrpcHost,
		serviceConfig.GrpcWebHost,
		logger,
		serviceConfig.PyposeService,
		serviceConfig.UploadDir,
		serviceConfig.PyposeOutputDir,
		serviceConfig.SymmetricKey,
	)

	sig := make(chan os.Signal, 1)
	signal.Notify(sig, syscall.SIGINT, syscall.SIGTERM)
	<-sig
}

func init() {
	initServiceConfig()
}

func initServiceConfig() {
	configName := "pose.config.yaml"

	viper.SetConfigType("yaml")
	viper.SetConfigName(configName)
	viper.AddConfigPath(".")
	viper.AddConfigPath("/etc/RoMA-T/")

	err := viper.ReadInConfig()
	if err != nil {
		switch err.(type) {
		case viper.ConfigFileNotFoundError:
			log.Fatalf("config file '%s' not found\n", configName)
		default:
			log.Fatalf("config error, %v\n", err)
		}
	}

	err = viper.Unmarshal(&serviceConfig)
	if err != nil {
		log.Fatalf("config error, %v\n", err)
	}

	err = serviceConfig.Validate()
	if err != nil {
		log.Fatalf("service config error, %v\n", err)
	}
}
