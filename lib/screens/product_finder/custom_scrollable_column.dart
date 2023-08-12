import 'package:flutter/material.dart';

import '../../globals/custom_app_bar.dart';
import 'components/custom_scrollable_tabbar.dart';
import 'components/other_finder_form.dart';
import 'components/trollies_finder_form.dart';
import 'components/castor_finder_form.dart';
import 'components/wheel_finder_form.dart';

class CustomScrollableColumn extends StatefulWidget {
  //
  //
  final double mobWidth;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomScrollableColumn({super.key, required this.mobWidth, required this.scaffoldKey}); // Constructor to receive the variable
  //
  //
  @override
  _CustomScrollableColumnState createState() => _CustomScrollableColumnState(mobWidth: mobWidth);
}

class _CustomScrollableColumnState extends State<CustomScrollableColumn> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //
  //
  final double mobWidth;

  _CustomScrollableColumnState({required this.mobWidth});

  get scaffoldKey => widget.scaffoldKey;

  //
  //

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //
      //
      // added background image to application section container (fixed on screen)
      //
      //
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            title: "Product Finder",
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: CustomScrollableTabBar(tabController: _tabController),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                //
                // castor finder
                //
                CastorFinderForm(),
                //
                // wheels finder
                //
                WheelFinderForm(),
                //
                // Trollies finder
                //
                TrolliesFinderForm(),
                //
                // Other finder
                //
                OtherFinderForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

