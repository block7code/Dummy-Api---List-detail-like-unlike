import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String image;
  final double imageSize;
  final double whiteMargin;
  final double imageMargin;
  final bool isNetwork;
  const CircleImage(
    this.image, {
    Key? key,
    this.imageSize = 70.0,
    this.whiteMargin = 2.5,
    this.imageMargin = 4.0,
    required this.isNetwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageSize,
      width: imageSize,
      margin: const EdgeInsets.all(8.0),
      // White background container between image and gradient
      child: Container(
        margin: EdgeInsets.all(whiteMargin),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.purple,
        ),

        // Image container
        child: FittedBox(
            child: Container(
                margin: EdgeInsets.all(imageMargin),
                height: 90.0,
                width: 90.0,
                decoration: isNetwork
                    ? BoxDecoration(
                        // borderRadius: BorderRadius.circular(50.0),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          // image: AssetImage(image),
                          image: NetworkImage(image),
                        ),
                      )
                    : BoxDecoration(
                        // borderRadius: BorderRadius.circular(50.0),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(image),
                        ),
                      ))),
        // Image container
        //
      ),
    );
  }
}
