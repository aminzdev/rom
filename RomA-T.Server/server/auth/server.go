package main

import (
	"RomA-T.Server/config"
	"RomA-T.Server/memory"
	"RomA-T.Server/model"
	"RomA-T.Server/service/authentication"
	"github.com/spf13/viper"
	"log"
	"os"
	"os/signal"
	"syscall"
)

var serviceConfig config.AuthServiceConfig

func main() {
	logger, err := os.OpenFile(serviceConfig.LogFile, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatalf("could not open log file, %v\n", err)
	}

	mem, err := memory.NewMemory(
		&memory.Postgres{
			Host:     serviceConfig.Postgres.Host,
			User:     serviceConfig.Postgres.User,
			Pass:     serviceConfig.Postgres.Pass,
			DBName:   serviceConfig.Postgres.DBName,
			SSL:      serviceConfig.Postgres.SSL,
			TimeZone: serviceConfig.Postgres.TimeZone,
		},
		logger,
		&model.User{},
		&model.Session{},
	)
	if err != nil {
		log.Fatalf("could not initiate memory, %v\n", err)
	}

	go authentication.RunServer(
		serviceConfig.GrpcHost,
		serviceConfig.GrpcWebHost,
		mem,
		logger,
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
	configName := "auth.config.yaml"

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
