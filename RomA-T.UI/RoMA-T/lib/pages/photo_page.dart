import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:rom/extensions/layout_extension.dart';
import 'package:rom/models/estimated_pose.dart';

class PhotoPage extends GetResponsiveView {
  PhotoPage({super.key});

  @override
  Widget? phone() {
    final estimatedPose = Get.arguments as EstimatedPose;

    return Scaffold(
      appBar: AppBar(title: const Text('Estimations')),
      body: PhotoViewGallery(
        pageOptions: estimatedPose.imageBytes
            .asMap()
            .entries
            .map(
              (e) => PhotoViewGalleryPageOptions(
                imageProvider: MemoryImage(e.value),
                heroAttributes: PhotoViewHeroAttributes(tag: "tag ${e.key}"),
              ),
            )
            .toList(),
      ),
    );
  }
}
