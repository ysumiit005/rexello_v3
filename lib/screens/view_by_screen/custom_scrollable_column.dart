import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'components/custom_app_bar.dart';
import 'components/custom_scrollable_tabbar.dart';
import 'components/view_application_section.dart';
import 'components/view_products_section.dart';
import 'shared_function/custom_pageviewscroll_physics.dart';

class CustomScrollableColumn extends StatefulWidget {
  //
  //
  final double mobWidth;
  final dynamic scaffoldKey;
  final int initialtabIndex;

  const CustomScrollableColumn(
      {super.key, required this.mobWidth, required this.scaffoldKey, required this.initialtabIndex}); // Constructor to receive the variable
  //
  //
  @override
  CustomScrollableColumnState createState() => CustomScrollableColumnState();
}

class CustomScrollableColumnState extends State<CustomScrollableColumn>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<CustomScrollableColumn> {
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  get getInitialTabIndex => widget.initialtabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 0),
      initialIndex: getInitialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          scaffoldKey: widget.scaffoldKey,
          title: "View By",
        ),
        CustomScrollableTabBar(tabController: _tabController),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            clipBehavior: Clip.none,
            physics: const CustomPageViewScrollPhysics(),
            children: const [
              //
              // products screen
              //
              ViewProductsSection(),

              //
              // applications screen
              //
              ViewApplicationSection(),
            ],
          ),
        ),
      ],
    );
  }
}
