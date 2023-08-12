import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../globals/device_size.dart';
// import 'package:rexello_tests_only_home/globals/device_size.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Builder(builder: (BuildContext context) {
            final double mobWidth = MediaQuery.of(context).size.width;
            return CustomScrollableColumn(mobWidth: mobWidth);
          }),
        ),
        //
        // custom bottom nav
        //
        bottomNavigationBar: Builder(builder: (context) {
          final double mobWidth = MediaQuery.of(context).size.width;
          return SizedBox(
            width: mobWidth,
            height: 55,
            child: Row(
              children: [
                //
                // ask an expert
                //
                Container(
                  color: Colors.blue,
                  width: mobWidth / 2,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Ask an Expert ",
                        style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 23,
                      )
                    ],
                  ),
                ),
                // request a quote
                Container(
                  color: Colors.red,
                  width: mobWidth / 2,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Send an Enquiry",
                        style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.mail,
                        color: Colors.white,
                        size: 23,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CustomScrollableColumn extends StatefulWidget {
  //
  //
  final double mobWidth; // Declare the variable in CustomScrollableColumn

  const CustomScrollableColumn(
      {super.key,
      required this.mobWidth}); // Constructor to receive the variable
  //
  //
  @override
  CustomScrollableColumnState createState() => CustomScrollableColumnState();
}

class CustomScrollableColumnState extends State<CustomScrollableColumn>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          mobWidth: DeviceSize.width,
        ),
        // SizedBox(height: 10),
        Container(
          color: Colors.red,
          height: 45,
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            // change tab indicator bar below tabs text
            indicator: CustomTabIndicator(
              // Use the custom tab indicator
              indicatorHeight: 5.0,
              indicatorWidth: 125.0, // Set the custom height for the indicator
              indicatorColor:
                  Colors.black, // Set the custom color for the indicator
            ),

            tabs: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Tab(
                  child: Text(
                    'PRODUCTS',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Tab(
                  child: Text(
                    'APPLICATIONS',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const CustomContent(pageIndex: 0),
              const CustomContent(pageIndex: 1),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.mobWidth,
  });

  final double mobWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: mobWidth,
      color: Colors.blue,
      child: Row(
        children: [
          //
          // back button appbar
          //
          Container(
            height: 60,
            // color: Colors.red,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(
              // color: Colors.yellow,
              height: 60,
              child: Center(
                child: Text(
                  "Dynamic Series",
                  style: TextStyle(
                    fontFamily: 'Exo_2',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            // color: Colors.red,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: const Center(
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContent extends StatelessWidget {
  final int pageIndex;

  const CustomContent({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Text(
          'Page ${pageIndex + 1}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), label: 'Search'),
      ],
    );
  }
}

//
//
// customises the tabindicator (line below tabs which slides)
// here we custoomise only height and width and color properties
//
//
class CustomTabIndicator extends Decoration {
  final double indicatorHeight;
  final double indicatorWidth;
  final Color indicatorColor;

  CustomTabIndicator({
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
