import 'package:flutter/material.dart';
// import 'package:rexello_tests_only_home/globals/device_size.dart';
// import 'package:rexello_tests_only_home/screens/product_finder/product_finder.dart';
// import 'package:rexello_tests_only_home/screens/view_by_screen/view_by_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../globals/device_size.dart';
import '../about_us_webview/about_us_webview_screen.dart';
import '../product_finder/product_finder.dart';
import '../view_by_screen/view_by_screen.dart';
import 'components/custom_drawer_tiles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: DeviceSize.width * 0.67,
        child: Drawer(
          backgroundColor: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              //
              // Rexello Logo
              //
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewByScreen(
                        initialTabIndex: 0,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 175,
                  color: Color(0xFF073358),
                  // padding: const EdgeInsets.only(top: 55, left: 60, right: 55, bottom: 38),
                  child: Center(
                    child: Image.asset(
                      "assets/images/drawer/rexello_logo_with_exposure.png",
                      height: 100,
                    ),
                  ),
                ),
              ),
              //
              // drawer tiles
              //
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 9, left: 10, right: 7, bottom: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 410,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 13, bottom: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          //
                          // home
                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewByScreen(
                                    initialTabIndex: 0,
                                  ),
                                ),
                              );
                            },
                            child: CustomDrawerTiles(
                              getIcon: "assets/svgs/drawer/ic_round-home.svg",
                              getTitle: 'Home',
                            ),
                          ),
                          //
                          // About Us
                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutUsWebViewScreen(
                                    rexUrl: 'https://rexello.com/company_profile',
                                    title: 'About Us',
                                  ),
                                ),
                              );
                            },
                            child: CustomDrawerTiles(
                              getIcon: "assets/svgs/drawer/about.svg",
                              getTitle: 'About Us',
                            ),
                          ),
                          //
                          // ProductFinder
                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductFinderScreen(),
                                ),
                              );
                            },
                            child: CustomDrawerTiles(
                              getIcon: "assets/svgs/drawer/vaadin_search.svg",
                              getTitle: 'Product Finder',
                            ),
                          ),
                          //
                          // Products
                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewByScreen(
                                    initialTabIndex: 0,
                                  ),
                                ),
                              );
                            },
                            child: CustomDrawerTiles(
                              getIcon: "assets/svgs/drawer/solar_wheel-linear.svg",
                              getTitle: 'Products',
                            ),
                          ),
                          //
                          // Applications
                          //
                          InkWell(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => ViewByScreen(
                                            initialTabIndex: 1,
                                          )),
                                  (route) => false,
                                );
                              });
                            },
                            child: CustomDrawerTiles(
                              getIcon: "assets/svgs/drawer/carbon_application-web.svg",
                              getTitle: 'Applications',
                            ),
                          ),
                          //
                          // Contact
                          //
                          InkWell(
                            onTap: () async {
                              Uri phoneno = Uri.parse('tel:+918828471344');
                              if (await launchUrl(phoneno)) {
                                //dialer opened
                              } else {
                                //dailer is not opened
                              }
                            },
                            child: CustomDrawerTiles(
                              getIcon: "assets/svgs/drawer/teenyicons_contact-outline.svg",
                              getTitle: 'Contact',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
