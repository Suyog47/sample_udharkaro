import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:udhaarkaroapp/constants/constants.dart';


class CircularLoader extends StatelessWidget {
  final int load;
  final bool bgContainer;
  final Color color;
  const CircularLoader(
      {this.load, this.bgContainer = true, this.color = blueColor,});

  @override
  Widget build(BuildContext context) {
    return (load == 1)
        ? bgContainer
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: blackColor.withOpacity(0.3),
                child: SpinKitCircle(
                  color: color,
                  size: 60.0,
                ),
              )
            : SpinKitCircle(
                color: color,
                size: 60.0,
              )
        : const Text("");
  }
}

class FoldingCubeLoader extends StatelessWidget {
  final int load;
  final bool bgContainer;
  final Color color;
  const FoldingCubeLoader(
      {this.load, this.bgContainer = true, this.color = blueColor,});

  @override
  Widget build(BuildContext context) {
    return (load == 1)
        ? bgContainer
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: blackColor.withOpacity(0.3),
                child: SpinKitFoldingCube(
                  color: color,
                  size: 60.0,
                ),
              )
            : SpinKitFoldingCube(
                color: color,
                size: 60.0,
              )
        : const Text("");
  }
}
