import 'package:flutter/material.dart';

import '../../../globals/device_size.dart';
import '../product_finder.dart';

class CustomScrollableTabBar extends StatefulWidget {
  const CustomScrollableTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<CustomScrollableTabBar> createState() => _CustomScrollableTabBarState();
}

class _CustomScrollableTabBarState extends State<CustomScrollableTabBar> {
  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    // ignore: unused_local_variable
    double figmascreensizeWidth = 390;
    double figmascreensizeHeight = 844;
    return ClipRect(
      child: Container(
        height: DeviceSize.height * (45 / figmascreensizeHeight),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF),
        ),
        child: TabBar(
          controller: widget._tabController,
          isScrollable: false,
          labelPadding: const EdgeInsets.all(0), // solves tabbar text expanding to second line

          // change tab indicator bar below tabs text
          indicator:
              BoxDecoration(color: const Color(0xFF073358), borderRadius: BorderRadius.circular(10) // Set the background color of the selected tab
                  ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,

          tabs: [
            Container(
              child: Tab(
                child: Text(
                  'Castors',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: DeviceSize.width * 0.033,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              child: Tab(
                child: Text(
                  'Wheels',
                  style: TextStyle(
                    fontFamily: 'Inter',
                     fontSize: DeviceSize.width * 0.033,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              child: Tab(
                child: Text(
                  'Trollies',
                  style: TextStyle(
                    fontFamily: 'Inter',
                     fontSize: DeviceSize.width * 0.033,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              child: Tab(
                child: Text(
                  'Others',
                  style: TextStyle(
                    fontFamily: 'Inter',
                     fontSize: DeviceSize.width * 0.033,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
