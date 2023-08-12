import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../globals/custom_bottom_nav_bar.dart';
import '../../globals/device_size.dart';
import '../../globals/launch_wassup.dart';
import '../drawer/custom_drawer.dart';
import 'custom_scrollable_column.dart';

//temp delete or comment later
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewByScreen(
        initialTabIndex: 0,
      ),
    );
  }
}

//
// starts below
//
class ViewByScreen extends StatefulWidget {
  const ViewByScreen({
    super.key,
    required this.initialTabIndex,
  });
  final int initialTabIndex;

  @override
  State<ViewByScreen> createState() => _ViewByScreenState();
}

class _ViewByScreenState extends State<ViewByScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get getIntialTabIndex => widget.initialTabIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          print("cant go back customised");
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              //main page with tabs and content and appbar
              Builder(
                builder: (BuildContext context) {
                  //
                  // scrollable column with \
                  // custom tabbar , custom appbar
                  //
                  return CustomScrollableColumn(
                    mobWidth: DeviceSize.width,
                    scaffoldKey: _scaffoldKey,
                    initialtabIndex: getIntialTabIndex,
                  );
                },
              ),
              //left fixed product finder
              Positioned(
                left: 0,
                top: DeviceSize.height / 2 - (170 / 2), // Adjust the top value to position the container vertically
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/finder',
                    );
                  },
                  child: Container(
                    width: 35,
                    height: DeviceSize.height * (170 / DeviceSize.figmascreensizeHeight),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 7, 7, 0.75),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: const RotatedBox(
                      quarterTurns: 1,
                      child: Center(
                        child: Text(
                          "Product Finder",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //
          // custom bottom nav
          //
          bottomNavigationBar: const CustomBottonNavBar(),
          floatingActionButton: SizedBox(
            height: DeviceSize.width * (70 / DeviceSize.figmascreensizeWidth),
            width: DeviceSize.width * (70 / DeviceSize.figmascreensizeWidth),
            child: FloatingActionButton(
              onPressed: () {
                // Add your action here
                launchWhatsApp();
              },
              backgroundColor: const Color(0x9025D366),
              child: Image.asset(
                "assets/images/whatsapp_button.png",
                height: 35,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
          endDrawer: const CustomDrawer(),
        ),
      ),
    );
  }
}

//
//
// cgpt
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Set the custom position of the floating action button
    final double x = scaffoldGeometry.scaffoldSize.width - DeviceSize.width * (85 / DeviceSize.figmascreensizeWidth);

    final double y = DeviceSize.height - (DeviceSize.height * 0.20);

    return Offset(x, y);
  }
}
