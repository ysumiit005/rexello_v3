import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../globals/device_size.dart';
import '../../series_screen/series_screen.dart';
import '../custom_widgets/custom_circular_loader_on_fetch_list.dart';

class OtherFinderForm extends StatefulWidget {
  const OtherFinderForm({
    super.key,
  });

  @override
  State<OtherFinderForm> createState() => _OtherFinderFormState();
}

class _OtherFinderFormState extends State<OtherFinderForm> {
  //
  // variable to save user input using bottom modal
  // var
  String? otherProductName;

  //list of data
  // List<String> castorTypeList = ["Swivel", "Castor"];
  late List<String> otherProductNameList;

  void _showBottomDrawer1(BuildContext context, String optionTitle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
      builder: (BuildContext context) {
        // bottom modal UI for series name
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          padding: const EdgeInsets.only(top: 25),
          child: (() {
            if (optionTitle == "Choose Product") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: otherProductNameList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                otherProductName = otherProductNameList[index];
                                //closes modal automatic after user selects option in modal
                                Navigator.pop(context);
                              });
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(otherProductNameList[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "Some Issue See If Else Block : string passed from ui dont match if condition string",
                  style: TextStyle(fontSize: 11),
                ),
              );
            }
          })(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    // ignore: unused_local_variable
    double figmascreensizeWidth = 390;
    double figmascreensizeHeight = 844;
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 30),
            child: Column(
              children: [
                SizedBox(
                  height: DeviceSize.height * (35 / figmascreensizeHeight),
                ),

                //
                //
                // Product Name  :
                //
                //

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          "Choose Product : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      //
                      //input box
                      GestureDetector(
                        onTap: () {
                          _showBottomDrawer1(context, "Choose Product");
                        },
                        child: Container(
                          height: 45,
                          width: 290,
                          margin: const EdgeInsets.only(left: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO(25, 37, 136, 0.15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        otherProductName ?? "Select Product Name",
                                        style: const TextStyle(
                                          color: Color(0xFF706C6C),
                                        ),
                                      )),
                                ),
                                //
                                // clear icon
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      otherProductName = null;
                                    });

                                    //
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: double.infinity,
                                    // color: Colors.yellow,
                                    child: otherProductName != null
                                        ? const Icon(
                                            Icons.close,
                                            size: 20,
                                            color: Color.fromARGB(74, 0, 0, 0),
                                          )
                                        : null,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //
                //
                // submit button (Other)
                //
                //
                SizedBox(
                  height: DeviceSize.height * (30 / figmascreensizeHeight),
                ),
                GestureDetector(
                  onTap: () {
                    // print(
                    //     "https://rexello.com/api/product_finder_api/get_others_api.php?other_name=footlock");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesScreen(
                          getUrl:
                              "https://rexello.com/api/product_finder_api/get_others_api.php?other_name=$otherProductName",
                          type: 'others',
                          title: "",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 290,
                    margin: const EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(color: const Color(0xFF073358), borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //
                // manual gap
                //
                SizedBox(
                  height: DeviceSize.height * (30 / figmascreensizeHeight),
                ),
              ],
            ),
          ),
          //
          // show circular loader when list loading
          //
          if (dataListLoadingFromApi == true) const CustomCircularLoaderOnFetchList(),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////
  //
  //
  // state
  //
  //
  @override
  void initState() {
    super.initState();
    apiUrlForAjax = 'https://rexello.com/api/product_type_async_api/get_others_series.php';
    fetchListDataAll();
  }

  /////////////////////////////////////////////////////////////////////////////////////
  //
  //
  // variables
  //
  //
  late String apiUrlForAjax;
  bool dataListLoadingFromApi = true; // to show loader when list are loading from api

  ////////////////////////////////////////////////////////////////////////////////////
  //
  // db function
  //
  //
  //
  List<User> userList = [];

  //
  // ajax like function to load form options list
  /////////////////////////////////
  Future<void> fetchListDataAll() async {
    //
    // show loader to pause user interaction untill data is fetched
    //
    dataListLoadingFromApi = true;

    //
    // shoots url
    //
    apiUrlForAjax = 'https://rexello.com/api/product_type_async_api/get_others_series.php';
    var response = await http.get(Uri.parse(apiUrlForAjax));
    print(apiUrlForAjax);

    //
    // gets response and process it
    //
    if (response.statusCode == 200) {
      //
      // get json
      var jsonData = json.decode(response.body);

      //
      // save json data to userList Model list
      if (jsonData is Map) {
        //
        // only add data on index 0 each time
        userList.insert(
          0,
          User(
            trolleyList: List<String>.from(jsonData['other_name_list']),
          ),
        );
      } else {
        throw Exception('Invalid jsonData format');
      }

      //
      // update all list with new data on index 0 not 1
      //
      if (mounted) {
        // solves memory leak check if setstate is mounted then only goes ahead
        setState(() {
          // trolleyType = userList[0].type;
          otherProductNameList = (userList[0].trolleyList).cast<String>();

          //
          // show loader to pause user interaction untill data is fetched
          //
          dataListLoadingFromApi = false;
        });
      }
    } else {
      throw Exception('Failed to fetch jsonData');
    }
  }
}

/////////////////////////////////////////////////////////////
//
// class models
//
//
//
class User {
  List trolleyList;

  User({
    required this.trolleyList,
  });
}
