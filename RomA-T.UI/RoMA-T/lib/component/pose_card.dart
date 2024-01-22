import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoseCard extends GetView {
  const PoseCard({
    super.key,
    required this.title,
    this.onTap,
    this.onLongPress,
  });

  final String title;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(30),
          child: ListTile(title: Text(title)),
        ),
      ),
    );
  }
}
