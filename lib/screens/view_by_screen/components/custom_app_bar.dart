import 'package:flutter/material.dart';

import '../../../globals/device_size.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.title,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  void openDrawer() {
    widget.scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    double figmascreensizeWidth = 390;
    double figmascreensizeHeight = 844;

    return Container(
      height: DeviceSize.height * (60 / figmascreensizeHeight),
      width: DeviceSize.width,
      color: const Color(0xFF073358),
      child: Row(
        children: [
          //
          // back icon
          //
          Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(left: 12, right: 8),
          ),
          //
          //title
          //
          Expanded(
            child: SizedBox(
              // color: Colors.yellow,

              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Exo_2',
                    fontSize: DeviceSize.height * (20 / figmascreensizeHeight),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          //
          // drawer icon
          //
          InkWell(
            onTap: openDrawer,
            child: Container(
              height: 60,
              // color: Colors.red,
              padding: EdgeInsets.only(left: DeviceSize.width * (10 / figmascreensizeWidth), right: DeviceSize.width * (8 / figmascreensizeWidth)),
              child: Center(
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: DeviceSize.height * (26 / figmascreensizeHeight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
