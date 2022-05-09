import 'dart:io';
import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/constants/constants.dart';


class Avatar extends StatelessWidget {
  final String networkImg;
  final File galleryImg;
  final double radius;

  const Avatar({this.networkImg = "", this.galleryImg, this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: (networkImg == "" && galleryImg == null)
          ? Image.asset(
              'assets/images/profile_bg.png',
              fit: BoxFit.contain,
            ).image
          : (networkImg != "" && galleryImg == null)
              ? Image.network(
                  networkImg,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : const LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(redColor),
                        ),
                ).image
              : Image.file(
                  galleryImg,
                  fit: BoxFit.fill,
                ).image,
    );
  }
}
