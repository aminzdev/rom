package model

type EstimatedAngles struct {
	LeftKneeAngles      []float32 `json:"left_knee_angles"`
	RightKneeAngles     []float32 `json:"right_knee_angles"`
	LeftHipAngles       []float32 `json:"left_hip_angles"`
	RightHipAngles      []float32 `json:"right_hip_angles"`
	LeftElbowAngles     []float32 `json:"left_elbow_angles"`
	RightElbowAngles    []float32 `json:"right_elbow_angles"`
	LeftShoulderAngles  []float32 `json:"left_shoulder_angles"`
	RightShoulderAngles []float32 `json:"right_shoulder_angles"`
}
