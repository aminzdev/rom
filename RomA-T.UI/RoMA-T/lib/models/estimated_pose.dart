import 'dart:typed_data';

import 'package:flutter/material.dart';

class EstimatedPose {
  EstimatedPose({
    required this.images,
    required this.imageBytes,
    required this.angles,
  });

  final List<Image> images;
  final List<Uint8List> imageBytes;
  final Map<String, List<double>> angles;
}
