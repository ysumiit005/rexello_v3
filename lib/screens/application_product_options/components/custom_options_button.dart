import 'package:flutter/material.dart';

import '../../../globals/device_size.dart';

class CustomOptionButton extends StatelessWidget {
  const CustomOptionButton({
    super.key,
    required this.productTypeText,
    required this.productTypeImage,
    required this.productTypeBgColor,
  });

  final String productTypeText;
  final String productTypeImage;
  final Color productTypeBgColor;

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);

    return Center(
      child: Container(
        width: DeviceSize.width * (350 / DeviceSize.figmascreensizeWidth),
        height: DeviceSize.height * (120 / DeviceSize.figmascreensizeHeight),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: productTypeBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: DeviceSize.width * (150 / DeviceSize.figmascreensizeWidth), // Half the width
              // color: Colors.amber,
              padding: EdgeInsets.only(left: (DeviceSize.width * (28 / DeviceSize.figmascreensizeWidth))),
              child: Text(
                "$productTypeText",
                style: const TextStyle(
                  fontFamily: 'Exo_2',
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ), //assets/images/options_application/castors.png
            Positioned(
              top: -35,
              right: 0, // Adjust this value to move the image out of the container
              child: Image.asset(
                "$productTypeImage", // Replace with your image URL
                height: DeviceSize.height * (210 / DeviceSize.figmascreensizeHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
