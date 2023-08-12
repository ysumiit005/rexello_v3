import 'package:flutter/material.dart';

import '../../globals/custom_app_bar.dart';
import '../../globals/device_size.dart';
import '../../models/application_model.dart';
import '../drawer/custom_drawer.dart';
import '../series_screen/series_screen.dart';
// import '../view_by_screen/model/application_model.dart';
import 'components/custom_options_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApplicationsProductOptionsScreen(
        xyz: ApplicationModel(apiUrl: '', id: 1, image: '', title: '', type: '', webUrl: ''),
      ),
    );
  }
}

class ApplicationsProductOptionsScreen extends StatefulWidget {
  const ApplicationsProductOptionsScreen({super.key, required this.xyz});

  final ApplicationModel xyz;

  @override
  State<ApplicationsProductOptionsScreen> createState() => _ApplicationsProductOptionsScreenState();
}

class _ApplicationsProductOptionsScreenState extends State<ApplicationsProductOptionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Container(
            height: DeviceSize.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // custom appbar
                //
                CustomAppBar(
                  scaffoldKey: _scaffoldKey,
                  title: '',
                ),
                //
                // body container
                //
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //
                          // text - product we serve in
                          //
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 20),
                            width: DeviceSize.width * (270 / DeviceSize.figmascreensizeWidth),
                            // color: Colors.amber,
                            child: Text(
                              "Products we serve in ${widget.xyz.type}",
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22, fontFamily: 'Exo_2'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          //
                          // products card
                          //

                          //castors
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeriesScreen(
                                    getUrl: widget.xyz.castorApiUrl!,
                                    type: "castors",
                                    title: "",
                                    // title: "${widget.xyz.type} castors",
                                  ),
                                ),
                              );
                            },
                            child: const CustomOptionButton(
                              productTypeText: 'Castors',
                              productTypeImage: 'assets/images/options_application/castors.png',
                              productTypeBgColor: Color(0xFF073358),
                            ),
                          ),
                          // trollies
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeriesScreen(
                                    getUrl: widget.xyz.wheelApiUrl!,
                                    type: "wheels",
                                    title: "",
                                  ),
                                ),
                              );
                            },
                            child: const CustomOptionButton(
                              productTypeText: 'Wheels',
                              productTypeImage: 'assets/images/options_application/wheels.png',
                              productTypeBgColor: Color(0xFF343636),
                            ),
                          ),
                          // wheels
                          // trollies
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeriesScreen(
                                    getUrl: widget.xyz.trolleyApiUrl!,
                                    type: "trolleys",
                                    title: "",
                                  ),
                                ),
                              );
                            },
                            child: const CustomOptionButton(
                              productTypeText: 'Trolleys',
                              productTypeImage: 'assets/images/options_application/trolleys.png',
                              productTypeBgColor: Color(0xFF2A359B),
                            ),
                          ),
                          //others
                          // trollies
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeriesScreen(
                                    getUrl: widget.xyz.otherApiUrl!,
                                    type: "others",
                                    title: "",
                                  ),
                                ),
                              );
                            },
                            child: const CustomOptionButton(
                              productTypeText: 'Others',
                              productTypeImage: 'assets/images/options_application/others.png',
                              productTypeBgColor: Color(0xFF35454A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        endDrawer: const CustomDrawer());
  }
  //
  //
  // var
  //
  //
}
