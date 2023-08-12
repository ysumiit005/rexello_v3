import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:rexello_tests_only_home/screens/series_screen/series_screen.dart';
import '../../../globals/device_size.dart';
import '../../series_screen/series_screen.dart';
import '../custom_widgets/custom_circular_loader_on_fetch_list.dart';

class TrolliesFinderForm extends StatefulWidget {
  const TrolliesFinderForm({
    super.key,
  });

  @override
  State<TrolliesFinderForm> createState() => _TrolliesFinderFormState();
}

class _TrolliesFinderFormState extends State<TrolliesFinderForm> {
  //
  // variable to save user input using bottom modal
  // var
  String trolleyType = "1";
  String? trolleyName;

  //list of data
  // List<String> castorTypeList = ["Swivel", "Castor"];
  late List<String> trolleyNameList;

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
            if (optionTitle == "Product Name") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: trolleyNameList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                trolleyName = trolleyNameList[index];
                                //closes modal automatic after user selects option in modal
                                Navigator.pop(context);
                              });
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(trolleyNameList[index]),
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

  //
  // variable for switching castor type ui colors from platform to other
  //
  Color platformBgColor = const Color(0xFF073358);
  Color platformFontColor = Colors.white;

  Color otherBgColor = Colors.white;
  Color otherFontColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);

    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: DeviceSize.height * (35 / DeviceSize.figmascreensizeHeight),
                  ),
                  //
                  //
                  // trolley type with switch buttons
                  //
                  //
                  Container(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const Text(
                            "Choose Trolley Type : ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      //
                      // switch button
                      //
                      Center(
                        child: Container(
                          width: 290,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF073358),
                                width: 1.0,
                              ),
                              color: Colors.white
                              // color: Colors.amber
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      platformBgColor = Color(0xFF073358);
                                      platformFontColor = Colors.white;
                                      otherBgColor = Colors.white;
                                      otherFontColor = Colors.black;

                                      //save userInput in var
                                      trolleyType = "1";
                                      // print(trolleyType);
                                    });

                                    // replace dataList with new using ajax concept func
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    height: 49,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      color: platformBgColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Platform',
                                      style: TextStyle(
                                        color: platformFontColor,
                                        fontFamily: 'Exo_2',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      platformBgColor = Colors.white;
                                      platformFontColor = Colors.black;
                                      otherBgColor = Color(0xFF073358);
                                      otherFontColor = Colors.white;

                                      //save userInput in var
                                      trolleyType = "2";
                                    });

                                    // replace dataList with new using ajax concept func
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    height: 49,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      color: otherBgColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Other',
                                      style: TextStyle(
                                        fontFamily: 'Exo_2',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: otherFontColor,
                                      ),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),

                  //
                  //
                  // Product Name  :
                  //
                  //
                  SizedBox(
                    height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Product Name : ",
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
                            _showBottomDrawer1(context, "Product Name");
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
                                        trolleyName ?? "Select Product Name",
                                        style: const TextStyle(
                                          color: Color(0xFF706C6C),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //
                                  // clear icon
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                       trolleyName = null;
                                      });

                                      //
                                      fetchListDataAll();
                                    },
                                    child: Container(
                                      width: 60,
                                      height: double.infinity,
                                      // color: Colors.yellow,
                                      child: trolleyName != null
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
                  // submit button (trolley)
                  //
                  //
                  SizedBox(
                    height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeriesScreen(
                            getUrl:
                                "https://rexello.com/api/product_finder_api/get_trolleys_api.php?trolley_type=$trolleyType&trolley_name=$trolleyName",
                            type: 'trolleys',
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
                    height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                  ),
                ],
              ),
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
    apiUrlForAjax =
        'https://rexello.com/api/product_type_async_api/get_trolley_series.php?trolley_type=$trolleyType';
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
    apiUrlForAjax =
        'https://rexello.com/api/product_type_async_api/get_trolley_series.php?trolley_type=$trolleyType';
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
            type: (jsonData['type']),
            trolleyList: List<String>.from(jsonData['trolley_list']),
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
          trolleyNameList = (userList[0].trolleyList).cast<String>();

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
  int type;
  List trolleyList;

  User({
    required this.type,
    required this.trolleyList,
  });
}
