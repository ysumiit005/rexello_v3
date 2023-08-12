// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../globals/custom_app_bar.dart';
import '../../globals/device_size.dart';
import '../../models/series_products.dart';
import '../drawer/custom_drawer.dart';
import '../request_quote_screen/request_quote_screen.dart';
// import '../view_by_screen/model/series_products.dart';
import 'components/series_cards.dart';
import 'package:http/http.dart' as http;

//temp delete or comment later
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SeriesScreen(
        getUrl: 'dummy',
        type: 'dummy',
      ),
    );
  }
}

//
// starts below
//
class SeriesScreen extends StatefulWidget {
  const SeriesScreen({
    super.key,
    required this.getUrl,
    required this.type,
    this.title,
  });

  final String getUrl;
  final String type;
  final String? title;

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool dataFetched = false;

  List<User> userList = [];

  String get getUrl => widget.getUrl;
  String get gettype => widget.type;
  String? get gettitle => widget.title;

  late String imageFolder;

  @override
  void initState() {
    super.initState();
    fetchData().then((value) async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        dataFetched = true;
      });
    });
  }

  //
  // function to fetch data on init from url
  //
  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(getUrl));
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        dynamic jsonData = json.decode(response.body);

        //
        // for castors
        //
        if (gettype == "castors") {
          imageFolder = "castors"; // set image folder to get images from url
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['series_name'],
                    image: item['series_image'],
                    weight: item['series_capacity'],
                    description: item['application_content'],
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['series_name'],
                image: jsonData['series_image'],
                weight: jsonData['series_capacity'],
                description: jsonData['application_content'],
              ),
            );
          }
        }
        //
        // for wheels
        //
        if (gettype == "wheels") {
          imageFolder = "wheels";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['wheel_code'],
                    image: item['wheel_image'],
                    weight: item['wheel_name'],
                    description: item['features'],
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['wheel_code'],
                image: jsonData['wheel_image'],
                weight: jsonData['wheel_name'],
                description: jsonData['features'],
              ),
            );
          }
        }
        //
        // for trolleys
        //
        if (gettype == "trolleys") {
          imageFolder = "trolleys";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['name'],
                    image: item['image'],
                    weight: item['weight'].toString(),
                    description: item['particulars'],
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['name'],
                image: jsonData['image'],
                weight: jsonData['weight'],
                description: jsonData['particulars'],
              ),
            );
          }
        }
        //
        // for other products
        //
        if (gettype == "others") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: item['descrp_for_mobile'],
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: jsonData['description'],
              ),
            );
          }
        }
        //
        // hospitals
        //
        if (gettype == "hospitals") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // shopping
        //
        if (gettype == "shopping") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // airp
        //
        if (gettype == "airports") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // firedep
        //
        if (gettype == "fire") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // harbour
        //
        if (gettype == "harbour") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // bridge
        //
        if (gettype == "bridge") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // waste water
        //
        if (gettype == "waste") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }

        //
        // recycling
        //
        if (gettype == "recycling") {
          imageFolder = "other_products";
          if (jsonData is List) {
            userList = jsonData
                .map(
                  (item) => User(
                    id: (item['id']),
                    name: item['other_name'],
                    image: item['other_image'],
                    weight: '',
                    description: '',
                  ),
                )
                .toList();
          } else if (jsonData is Map) {
            userList.add(
              User(
                id: (jsonData['id']),
                name: jsonData['other_name'],
                image: jsonData['other_image'],
                weight: '',
                description: '',
              ),
            );
          }
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);

    print("this bhau -> $getUrl");

    if (!dataFetched) {
      // Show loading indicator or any other UI while data is being fetched
      return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              //
              // custom appbar
              //
              CustomAppBar(
                scaffoldKey: _scaffoldKey,
                title: gettitle!,
              ),
              //
              // shimmers
              //
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceSize.width * (28 / DeviceSize.figmascreensizeWidth),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: DeviceSize.width * (30 / DeviceSize.figmascreensizeWidth),
                      mainAxisSpacing: 20,
                    ),
                    padding: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        direction: ShimmerDirection.ltr,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // custom appbar
              //
              CustomAppBar(
                scaffoldKey: _scaffoldKey,
                title: gettitle!,
              ),

              //
              // if userList is empty show nodata page to user
              //
              userList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: SizedBox(
                          height: DeviceSize.figmascreensizeHeight,
                          width: DeviceSize.figmascreensizeWidth,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: DeviceSize.width / 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Not found specific product, please fill out the form below, and we'll contact you soon.",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RequestQuoteScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF073358),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Form",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.arrow_circle_right,
                                            color: Colors.white,
                                            size: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Placeholder for your form
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  :
                  //
                  // content with grid list
                  //
                  Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,

                              padding: EdgeInsets.symmetric(
                                horizontal: DeviceSize.width * (28 / DeviceSize.figmascreensizeWidth),
                              ),
                              // implement GridView.builder
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 150,
                                      childAspectRatio: 0.78,
                                      crossAxisSpacing: DeviceSize.width * (30 / DeviceSize.figmascreensizeWidth),
                                      mainAxisSpacing: 20),
                                  itemCount: userList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    User user = userList[index];
                                    return SeriesCards(
                                      heroId: index,
                                      title: user.name,
                                      weight: user.weight,
                                      image: "https://rexello.com/images/$imageFolder/${user.image}",
                                      description: user.description,
                                      type: widget.type,
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        endDrawer: const CustomDrawer());
  }
}
