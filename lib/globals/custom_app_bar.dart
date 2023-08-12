import 'package:flutter/material.dart';

import 'device_size.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.title,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  String title;
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
          // back button appbar
          //
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              // color: Colors.red,
              padding: const EdgeInsets.only(left: 12, right: 15),
              // color: Colors.amber,
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: DeviceSize.height * (26 / figmascreensizeHeight),
                ),
              ),
            ),
          ),
          //
          // title
          //
          Expanded(
            child: SizedBox(
              // color: Colors.yellow,
              child: Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Exo_2',
                    fontSize: DeviceSize.height * (18 / figmascreensizeHeight),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

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
