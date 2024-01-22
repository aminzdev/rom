package pose

import (
	"RomA-T.Server/auth"
	"RomA-T.Server/model"
	"RomA-T.Server/protocol"
	"RomA-T.Server/request"
	"RomA-T.Server/util"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func (s *Server) AnalyseVideo(ctx context.Context, req *protocol.AnalyseVideoReq) (*protocol.AnalyseVideoRes, error) {
	reqx := request.FromContext(ctx)

	if len(req.Name) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("video name is empty"))
	}
	if len(req.Video) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("video is empty"))
	}
	if len(req.Joints) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("no joint provided"))
	}

	payload, err := auth.VerifyToken(s.tokenMaker, reqx.AccessToken)
	if err != nil {
		return nil, status.Error(codes.Unauthenticated, err.Error())
	}

	userName := payload.User
	videoName := req.Name
	userOutputDir := fmt.Sprintf("%s/%s/%s.d", s.pyposeOutputDir, userName, videoName)
	userUploadDir := fmt.Sprintf("%s/%s", s.uploadDir, userName)

	err = os.MkdirAll(userUploadDir, 0775)
	if err != nil && !os.IsExist(err) {
		return nil, status.Errorf(codes.Internal, "could not create user specific upload directory")
	}

	err = os.MkdirAll(userOutputDir, 0775)
	if err != nil && !os.IsExist(err) {
		return nil, status.Errorf(codes.Internal, "could not create user specific analysed directory")
	}

	var est model.EstimatedAngles

	if req.UseCached {
		empty, err := util.IsDirEmpty(userOutputDir)
		if err != nil {
			s.log.Error().Str("request", reqx.ID).Err(err).Send()
			return nil, status.Errorf(codes.Internal, "could not open user specific analysed directory")
		}
		if !empty {
			analysedFrames, err := s.findAnalysedFramesFromDir(userOutputDir, &est)
			if err != nil {
				s.log.Error().Str("request", reqx.ID).Err(err).Send()
				return nil, status.Error(codes.Internal, "could not find analysed frames")
			}

			angles := []*protocol.EstimatedAngles{
				{
					Joint:  protocol.Joint_LEFT_KNEE,
					Angles: est.LeftKneeAngles,
				},
				{
					Joint:  protocol.Joint_RIGHT_KNEE,
					Angles: est.RightKneeAngles,
				},
				{
					Joint:  protocol.Joint_LEFT_SHOULDER,
					Angles: est.LeftShoulderAngles,
				},
				{
					Joint:  protocol.Joint_RIGHT_SHOULDER,
					Angles: est.RightShoulderAngles,
				},
				{
					Joint:  protocol.Joint_LEFT_ELBOW,
					Angles: est.LeftElbowAngles,
				},
				{
					Joint:  protocol.Joint_RIGHT_ELBOW,
					Angles: est.RightElbowAngles,
				},
				{
					Joint:  protocol.Joint_LEFT_HIP,
					Angles: est.LeftHipAngles,
				},
				{
					Joint:  protocol.Joint_RIGHT_HIP,
					Angles: est.RightHipAngles,
				},
			}

			s.log.Info().Str("request", reqx.ID).Msgf("sending cached '%s' analysed frames to user '%s'", req.Name, userName)
			return &protocol.AnalyseVideoRes{
				AnalysedFrames: analysedFrames,
				Angles:         angles,
			}, nil
		}
	}

	err = saveFile(videoName, userUploadDir, req.Video)
	if err != nil {
		s.log.Error().Str("request", reqx.ID).Err(err).Send()
		return nil, status.Errorf(codes.Internal, "could not save video file")
	}

	var joints []string
	for _, joint := range req.Joints {
		joints = append(joints, strings.ToLower(joint.String()))
	}
	videoPath := fmt.Sprintf("%s/%s/%s", s.uploadDir, userName, videoName)
	err = s.pypose(videoPath, userOutputDir, joints, req.FrameStep, reqx.ID)
	if err != nil {
		if os.IsNotExist(err) {
			return nil, status.Errorf(codes.NotFound, "video '%s' not found", req.Name)
		}
		s.log.Error().Str("request", reqx.ID).Err(err).Send()
		return nil, status.Error(codes.Internal, "could not analyse video")
	}
	s.log.Info().Str("request", reqx.ID).Msgf("video '%s' analysed", req.Name)

	analysedFrames, err := s.findAnalysedFramesFromDir(userOutputDir, &est)
	if err != nil {
		s.log.Error().Str("request", reqx.ID).Err(err).Send()
		return nil, status.Error(codes.Internal, "could not find analysed frames")
	}

	angles := []*protocol.EstimatedAngles{
		{
			Joint:  protocol.Joint_LEFT_KNEE,
			Angles: est.LeftKneeAngles,
		},
		{
			Joint:  protocol.Joint_RIGHT_KNEE,
			Angles: est.RightKneeAngles,
		},
		{
			Joint:  protocol.Joint_LEFT_SHOULDER,
			Angles: est.LeftShoulderAngles,
		},
		{
			Joint:  protocol.Joint_RIGHT_SHOULDER,
			Angles: est.RightShoulderAngles,
		},
		{
			Joint:  protocol.Joint_LEFT_ELBOW,
			Angles: est.LeftElbowAngles,
		},
		{
			Joint:  protocol.Joint_RIGHT_ELBOW,
			Angles: est.RightElbowAngles,
		},
		{
			Joint:  protocol.Joint_LEFT_HIP,
			Angles: est.LeftHipAngles,
		},
		{
			Joint:  protocol.Joint_RIGHT_HIP,
			Angles: est.RightHipAngles,
		},
	}

	//analysedVideo, err := readFile(fmt.Sprintf("analysed_%s", videoName), s.pyposeOutputDir)
	//if err != nil {
	//	return nil, status.Error(codes.Internal, "could not find analysed video")
	//}

	// TODO remove analyzed files
	//_ = removeFile(videoName, s.userUploadDir)
	//_ = removeFile(fmt.Sprintf("analysed_%s", videoName), s.pyposeOutputDir)

	s.log.Info().Str("request", reqx.ID).Msgf("sending '%s' analysed frames to user '%s'", req.Name, userName)
	return &protocol.AnalyseVideoRes{
		AnalysedFrames: analysedFrames,
		Angles:         angles,
	}, nil
}

func (s *Server) pypose(videoPath, outputDir string, joints []string, frameStep uint32, reqID string) error {
	_, err := os.Stat(videoPath)
	if err != nil {
		return err
	}

	args := append([]string{s.pyposePath, videoPath, outputDir, strconv.Itoa(int(frameStep))}, joints...)
	//s.log.Info().Str("request", reqID).Msg(fmt.Sprintf("python %s", strings.Join(args, " ")))
	cmd := exec.Command("python", args...)
	output, err := cmd.CombinedOutput()
	if err != nil {
		return errors.New(string(output))
	}
	return nil
}

func (s *Server) findAnalysedFramesFromDir(outputDir string, est *model.EstimatedAngles) ([][]byte, error) {
	var analysedFrames [][]byte
	dir, err := os.ReadDir(outputDir)
	if err != nil {
		return nil, err
	}
	for _, file := range dir {
		path := fmt.Sprintf("%s/%s", outputDir, file.Name())
		bytes, err := os.ReadFile(path)
		if err != nil {
			return nil, err
		}
		if file.Name() == "estimations.json" {
			err := json.Unmarshal(bytes, &est)
			if err != nil {
				return nil, err
			}
		} else {
			analysedFrames = append(analysedFrames, bytes)
		}
	}
	return analysedFrames, nil
}

func saveFile(name, path string, data []byte) error {
	err := os.WriteFile(fmt.Sprintf("%s/%s", path, name), data, 0644)
	return err
}

func readFile(name, path string) ([]byte, error) {
	bytes, err := os.ReadFile(fmt.Sprintf("%s/%s", path, name))
	return bytes, err
}

func removeFile(name, path string) error {
	err := os.Remove(fmt.Sprintf("%s/%s", path, name))
	return err
}
