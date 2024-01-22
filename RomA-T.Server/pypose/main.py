import os
from typing import List
import json

import cv2 as cv
import lib.pose as pose
import ffmpeg
import argparse

import matplotlib.pyplot as plt


def process_video(video_file_path, output_dir_path, frame_step: int, angles: List[str]):
    est_angles = {
        "left_knee_angles": [],
        "right_knee_angles": [],
        "left_hip_angles": [],
        "right_hip_angles": [],
        "left_elbow_angles": [],
        "right_elbow_angles": [],
        "left_shoulder_angles": [],
        "right_shoulder_angles": [],
    }

    cap = cv.VideoCapture(video_file_path)
    rotateCode = check_rotation(video_file_path)
    width = int(cap.get(cv.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv.CAP_PROP_FRAME_HEIGHT))
    if width > 1000 and height > 1000:
        size = (width // 2, height // 2)
    else:
        size = (width // 1, height // 1)
    print(f"video frame size: {size}")
    # fourcc = cv.VideoWriter_fourcc(*'mp4v')

    out_path = f"{output_dir_path}/analysed_{os.path.basename(video_file_path)}"
    # out = cv.VideoWriter(out_path, fourcc, 20.0, size)

    frame_index = 0
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            if frame_index != 0:
                print(f'video processed -> {out_path}')
            else:
                print(f'could not process {video_file_path}')
            break

        frame_index += 1
        if frame_index % frame_step != 0:
            continue

        if rotateCode is not None and rotateCode == 90:
            frame = cv.flip(frame, 0)

        frame = cv.resize(frame, size)

        frame, est_angles = estimate_pose(frame, angles, est_angles)
        if frame is not None:
            # out.write(frame)
            out_image_path = f"{output_dir_path}/analysed_{os.path.basename(video_file_path)}_frame {frame_index}.png"
            cv.imwrite(out_image_path, frame)

    cap.release()
    # out.release()
    return est_angles


def estimate_pose(frame, angles: List[str], est_angles: dict[str, list[float]]):
    cv.cvtColor(frame, cv.COLOR_BGR2RGB)
    pose_detection = pose.PoseDetection()
    processed_frame = pose_detection.process_frame(frame, draw=True).processed_frame

    # knee landmarks
    left_knee_angle = ("LEFT_HIP", "LEFT_KNEE", "LEFT_ANKLE")
    right_knee_angle = ("RIGHT_HIP", "RIGHT_KNEE", "RIGHT_ANKLE")

    # hip landmarks
    left_hip_angle = ("LEFT_SHOULDER", "LEFT_HIP", "LEFT_KNEE")
    right_hip_angle = ("RIGHT_SHOULDER", "RIGHT_HIP", "RIGHT_KNEE")

    # elbow landmarks
    left_elbow_angle = ("LEFT_SHOULDER", "LEFT_ELBOW", "LEFT_WRIST")
    right_elbow_angle = ("RIGHT_SHOULDER", "RIGHT_ELBOW", "RIGHT_WRIST")

    # shoulder landmarks
    left_shoulder_angle = ("RIGHT_SHOULDER", "LEFT_SHOULDER", "LEFT_ELBOW")
    right_shoulder_angle = ("LEFT_SHOULDER", "RIGHT_SHOULDER", "RIGHT_ELBOW")

    for angle in angles:
        if angle == "left_knee":
            pose_detection.draw_angle(left_knee_angle)
            est_angles["left_knee_angles"].append(float(f"{pose_detection.angle(left_knee_angle):.1f}"))
        elif angle == "right_knee":
            pose_detection.draw_angle(right_knee_angle)
            est_angles["right_knee_angles"].append(float(f"{pose_detection.angle(right_knee_angle):.1f}"))
        elif angle == "left_hip":
            pose_detection.draw_angle(left_hip_angle)
            est_angles["left_hip_angles"].append(float(f"{pose_detection.angle(left_hip_angle):.1f}"))
        elif angle == "right_hip":
            pose_detection.draw_angle(right_hip_angle)
            est_angles["right_hip_angles"].append(float(f"{pose_detection.angle(right_hip_angle):.1f}"))
        elif angle == "left_elbow":
            pose_detection.draw_angle(left_elbow_angle)
            est_angles["left_elbow_angles"].append(float(f"{pose_detection.angle(left_elbow_angle):.1f}"))
        elif angle == "right_elbow":
            pose_detection.draw_angle(right_elbow_angle)
            est_angles["right_elbow_angles"].append(float(f"{pose_detection.angle(right_elbow_angle):.1f}"))
        elif angle == "left_shoulder":
            pose_detection.draw_angle(left_shoulder_angle)
            est_angles["left_shoulder_angles"].append(float(f"{pose_detection.angle(left_shoulder_angle):.1f}"))
        elif angle == "right_shoulder":
            pose_detection.draw_angle(right_shoulder_angle)
            est_angles["right_shoulder_angles"].append(float(f"{pose_detection.angle(right_shoulder_angle):.1f}"))

    return processed_frame, est_angles


def check_rotation(path_video_file):
    try:
        # this returns meta-data of the video file in form of a dictionary
        meta_dict = ffmpeg.probe(path_video_file)
        # from the dictionary, meta_dict['streams'][0]['tags']['rotate'] is the key
        # we are looking for
        rotate = meta_dict.get('streams', [dict(tags=dict())])[0].get('tags', dict()).get('rotate', 0)
        return round(int(rotate) / 90.0) * 90
    except ffmpeg.Error:
        return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Pose Detection")
    parser.add_argument("video", help="video file path to be analysed")
    parser.add_argument("output", help="output directory path to save analysed video")
    parser.add_argument("fstep", type=int, help="frame step")
    parser.add_argument("angles", nargs='*', type=str, help="space separated body part to specify the angle")
    args = parser.parse_args()

    estimations = process_video(
        video_file_path=args.video,
        output_dir_path=args.output,
        frame_step=args.fstep,
        angles=args.angles,
    )

    with open(f"{args.output}/estimations.json", "w") as outfile:
        outfile.write(json.dumps(estimations, indent=4))
