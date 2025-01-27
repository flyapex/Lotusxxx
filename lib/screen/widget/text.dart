import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/service/style/color.dart';

class TitleWithBorder extends StatelessWidget {
  final String title;
  const TitleWithBorder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        ),
        const Divider(color: Colors.black45, thickness: 0.5),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SubTitleWithBorder extends StatelessWidget {
  final String title;
  final String subtitle;
  final double padding;

  const SubTitleWithBorder({
    super.key,
    required this.title,
    required this.subtitle,
    this.padding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: secondary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: TextStyle(color: secondary),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    ).paddingSymmetric(vertical: padding);
  }
}
