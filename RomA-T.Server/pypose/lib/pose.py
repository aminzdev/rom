import cv2 as cv
import mediapipe as mp
import numpy as np


class PoseDetection:
    def __init__(self):
        self.landmark_positions: dict[str, np.ndarray] = {}
        self.pose_landmarks = None
        self.processed_frame = None

        self.mp_draw = mp.solutions.drawing_utils
        self.mp_pose = mp.solutions.pose
        self.pose = self.mp_pose.Pose()

        # https://google.github.io/mediapipe/solutions/pose#pose-landmark-model-blazepose-ghum-3d
        self.landmark_names = {
            self.mp_pose.PoseLandmark.NOSE: "NOSE",
            self.mp_pose.PoseLandmark.LEFT_EYE_INNER: "LEFT_EYE_INNER",
            self.mp_pose.PoseLandmark.LEFT_EYE: "LEFT_EYE",
            self.mp_pose.PoseLandmark.LEFT_EYE_OUTER: "LEFT_EYE_OUTER",
            self.mp_pose.PoseLandmark.RIGHT_EYE_INNER: "RIGHT_EYE_INNER",
            self.mp_pose.PoseLandmark.RIGHT_EYE: "RIGHT_EYE",
            self.mp_pose.PoseLandmark.RIGHT_EYE_OUTER: "RIGHT_EYE_OUTER",
            self.mp_pose.PoseLandmark.LEFT_EAR: "LEFT_EAR",
            self.mp_pose.PoseLandmark.RIGHT_EAR: "RIGHT_EAR",
            self.mp_pose.PoseLandmark.MOUTH_LEFT: "MOUTH_LEFT",
            self.mp_pose.PoseLandmark.MOUTH_RIGHT: "MOUTH_RIGHT",
            self.mp_pose.PoseLandmark.LEFT_SHOULDER: "LEFT_SHOULDER",
            self.mp_pose.PoseLandmark.RIGHT_SHOULDER: "RIGHT_SHOULDER",
            self.mp_pose.PoseLandmark.LEFT_ELBOW: "LEFT_ELBOW",
            self.mp_pose.PoseLandmark.RIGHT_ELBOW: "RIGHT_ELBOW",
            self.mp_pose.PoseLandmark.LEFT_WRIST: "LEFT_WRIST",
            self.mp_pose.PoseLandmark.RIGHT_WRIST: "RIGHT_WRIST",
            self.mp_pose.PoseLandmark.LEFT_PINKY: "LEFT_PINKY",
            self.mp_pose.PoseLandmark.RIGHT_PINKY: "RIGHT_PINKY",
            self.mp_pose.PoseLandmark.LEFT_INDEX: "LEFT_INDEX",
            self.mp_pose.PoseLandmark.RIGHT_INDEX: "RIGHT_INDEX",
            self.mp_pose.PoseLandmark.LEFT_THUMB: "LEFT_THUMB",
            self.mp_pose.PoseLandmark.RIGHT_THUMB: "RIGHT_THUMB",
            self.mp_pose.PoseLandmark.LEFT_HIP: "LEFT_HIP",
            self.mp_pose.PoseLandmark.RIGHT_HIP: "RIGHT_HIP",
            self.mp_pose.PoseLandmark.LEFT_KNEE: "LEFT_KNEE",
            self.mp_pose.PoseLandmark.RIGHT_KNEE: "RIGHT_KNEE",
            self.mp_pose.PoseLandmark.LEFT_ANKLE: "LEFT_ANKLE",
            self.mp_pose.PoseLandmark.RIGHT_ANKLE: "RIGHT_ANKLE",
            self.mp_pose.PoseLandmark.LEFT_HEEL: "LEFT_HEEL",
            self.mp_pose.PoseLandmark.RIGHT_HEEL: "RIGHT_HEEL",
            self.mp_pose.PoseLandmark.LEFT_FOOT_INDEX: "LEFT_FOOT_INDEX",
            self.mp_pose.PoseLandmark.RIGHT_FOOT_INDEX: "RIGHT_FOOT_INDEX",
        }

    def process_frame(self, frame, draw=True):
        self.pose_landmarks = self.pose.process(frame).pose_landmarks

        if not self.pose_landmarks:
            # raise Exception('could not process frame')
            return self

        if draw:
            self.mp_draw.draw_landmarks(frame, self.pose_landmarks, self.mp_pose.POSE_CONNECTIONS)

        self.processed_frame = frame

        for i, landmark in enumerate(self.pose_landmarks.landmark):
            h, w, c = self.processed_frame.shape
            cx, cy = int(landmark.x * w), int(landmark.y * h)
            self.landmark_positions[self.landmark_names[i]] = np.array([cx, cy])

            if draw:
                cv.circle(self.processed_frame, (cx, cy), 5, (255, 0, 0), cv.FILLED)

        return self

    def angle(self, landmark_names):
        a = self.landmark_positions[landmark_names[0]]
        b = self.landmark_positions[landmark_names[1]]
        c = self.landmark_positions[landmark_names[2]]

        ba = a - b
        bc = c - b

        cosine_angle = np.dot(ba, bc) / (np.linalg.norm(ba) * np.linalg.norm(bc))
        _angle = np.degrees(np.arccos(cosine_angle))

        return _angle

    def draw_angle(self, landmark_names: tuple[str, str, str]):
        if landmark_names[1] in self.landmark_positions:
            x, y = self.landmark_positions[landmark_names[1]] + 10
            cv.rectangle(self.processed_frame, (x, y - 15), (x + 50, y + 5), (0, 0, 0), -1)
            cv.putText(self.processed_frame, f"{self.angle(landmark_names):.1f}", (x, y), cv.FONT_HERSHEY_SIMPLEX, .5,
                       (255, 255, 255), 1, cv.LINE_AA)


if __name__ == "__main__":
    pass
