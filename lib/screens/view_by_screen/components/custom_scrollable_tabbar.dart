import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../globals/device_size.dart';
import '../shared_function/custom_pageviewscroll_physics.dart';

class CustomScrollableTabBar extends StatelessWidget {
  const CustomScrollableTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    double figmascreensizeWidth = 390;
    double figmascreensizeHeight = 844;
    return ClipRect(
      child: Container(
        color: const Color.fromRGBO(255, 0, 0, 1),
        height: DeviceSize.height * (45 / figmascreensizeHeight),
        width: MediaQuery.of(context).size.width,
        child: TabBar(
          physics: const CustomPageViewScrollPhysics(),
          controller: _tabController,
          isScrollable: false,
          dragStartBehavior: DragStartBehavior.down,
          // splashFactory: InkSparkle.splashFactory,

          // change tab indicator bar below tabs text
          indicator: CustomTabIndicator(
            // Use the custom tab indicator
            indicatorHeight: DeviceSize.height * (4.5 / figmascreensizeHeight),
            indicatorWidth: DeviceSize.width * (125 / figmascreensizeWidth),
            // Set the custom height for the indicator
            indicatorColor:
                Colors.black, // Set the custom color for the indicator
          ),

          tabs: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Tab(
                child: Text(
                  'PRODUCTS',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize:
                          DeviceSize.height * (17 / figmascreensizeHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Tab(
                child: Text(
                  'APPLICATIONS',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize:
                          DeviceSize.height * (17 / figmascreensizeHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
// customises the tabindicator (line below tabs which slides)
// here we customise only height and width and color properties
//
//
class CustomTabIndicator extends Decoration {
  final double indicatorHeight;
  final double indicatorWidth;
  final Color indicatorColor;

  const CustomTabIndicator({
    required this.indicatorHeight,
    required this.indicatorWidth,
    required this.indicatorColor,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    final double indicatorBottom = rect.bottom - decoration.indicatorHeight;
    final double indicatorLeft =
        rect.left + (rect.width - decoration.indicatorWidth) / 2.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          indicatorLeft,
          indicatorBottom,
          decoration.indicatorWidth,
          decoration.indicatorHeight,
        ),
        const Radius.circular(2.0),
      ),
      paint,
    );
  }
}
