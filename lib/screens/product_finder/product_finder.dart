import 'package:flutter/material.dart';
import '../../globals/device_size.dart';
import '../drawer/custom_drawer.dart';
import 'custom_scrollable_column.dart';

//temp delete or comment later
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductFinderScreen(),
    );
  }
}

//
// starts below
//
class ProductFinderScreen extends StatefulWidget {
  const ProductFinderScreen({
    super.key,
  });

  @override
  State<ProductFinderScreen> createState() => _ProductFinderScreenState();
}

class _ProductFinderScreenState extends State<ProductFinderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print('inside - product finder');
    DeviceSize.setScreenSize(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            //main page with tabs and content and appbar
            Builder(builder: (BuildContext context) {
              final double mobWidth = MediaQuery.of(context).size.width;
              //
              // scrollable column with \
              // custom tabbar , custom appbar
              //
              return CustomScrollableColumn(mobWidth: mobWidth, scaffoldKey: _scaffoldKey);
            }),
          ],
        ),
      ),
      endDrawer: const CustomDrawer()
    );
  }
}
