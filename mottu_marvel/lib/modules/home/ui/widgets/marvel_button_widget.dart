// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mottu_marvel/constants/app_colors.dart';

class MarvelButtonWidget extends StatelessWidget {
  final String text;
  final int width;
  final int height;
  final Function() onTap;
  const MarvelButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.width = 180,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.black,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 180,
          color: AppColors.red,
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
