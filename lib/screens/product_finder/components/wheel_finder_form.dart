import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../globals/device_size.dart';
import '../../series_screen/series_screen.dart';
import '../custom_widgets/custom_circular_loader_on_fetch_list.dart';

class WheelFinderForm extends StatefulWidget {
  const WheelFinderForm({
    super.key,
  });

  @override
  State<WheelFinderForm> createState() => _WheelFinderFormState();
}

class _WheelFinderFormState extends State<WheelFinderForm> {
  //
  // variable to save WheelAjaxApiModel input using bottom modal
  // var
  String? wheelMaterial;
  String? bearingType;
  String? wheelDiameter;
  String? loadCarryingCapacity;

  //list of data
  // List<String> castorTypeList = ["Swivel", "Castor"];
  late List<String> wheelMaterialList;
  late List<String> bearingTypeList;
  late List<String> wheelDiameterList;
  late List<String> loadCarryingCapacityList;

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
            if (optionTitle == "Wheel Material") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: wheelMaterialList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                wheelMaterial = wheelMaterialList[index];
                                //closes modal automatic after WheelAjaxApiModel selects option in modal
                                Navigator.pop(context);
                              });

                              //
                              fetchListDataAll();
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(wheelMaterialList[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (optionTitle == "Bearing Type") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bearingTypeList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                bearingType = bearingTypeList[index];
                                //closes modal automatic after WheelAjaxApiModel selects option in modal
                                Navigator.pop(context);
                              });

                              //
                              fetchListDataAll();
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(bearingTypeList[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (optionTitle == "Wheel Diameter") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: wheelDiameterList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                wheelDiameter = wheelDiameterList[index];
                                //closes modal automatic after WheelAjaxApiModel selects option in modal
                                Navigator.pop(context);
                              });

                              //
                              fetchListDataAll();
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(wheelDiameterList[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (optionTitle == "Load Carrying Capacity") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: loadCarryingCapacityList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                loadCarryingCapacity = loadCarryingCapacityList[index];
                                //closes modal automatic after WheelAjaxApiModel selects option in modal
                                Navigator.pop(context);
                              });

                              //
                              fetchListDataAll();
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(loadCarryingCapacityList[index]),
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

    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, right: 35),
            child: Column(
              children: [
                SizedBox(
                  height: DeviceSize.height * (35 / DeviceSize.figmascreensizeHeight),
                ),

                //
                //
                // Wheel Material :
                //
                //

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Wheel Material : ",
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
                          _showBottomDrawer1(context, "Wheel Material");
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
                                        wheelMaterial ?? "Eg. Rubber",
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
                                      wheelMaterial = null;
                                    });

                                    //
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: double.infinity,
                                    // color: Colors.yellow,
                                    child: wheelMaterial != null
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
                // Bearing Type :
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
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Bearing Types : ",
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
                          _showBottomDrawer1(context, "Bearing Type");
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
                                        bearingType ?? "Eg. trb ",
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
                                      bearingType = null;
                                    });

                                    //
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: double.infinity,
                                    // color: Colors.yellow,
                                    child: bearingType != null
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
                // Wheel Diameter  :
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
                        margin: EdgeInsets.only(bottom: 8),
                        child: const Text(
                          "Wheel Diameter (Range): ",
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
                          _showBottomDrawer1(context, "Wheel Diameter");
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
                                        wheelDiameter ?? "Eg 50 mm",
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
                                      wheelDiameter = null;
                                    });

                                    //
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: double.infinity,
                                    // color: Colors.yellow,
                                    child: wheelDiameter != null
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
                // Load carrying capacity :
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
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Load Carrying Capacity : ",
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
                          _showBottomDrawer1(context, "Load Carrying Capacity");
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
                                        loadCarryingCapacity ?? "Eg. 100 Kg",
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
                                      loadCarryingCapacity = null;
                                    });

                                    //
                                    fetchListDataAll();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: double.infinity,
                                    // color: Colors.yellow,
                                    child: loadCarryingCapacity != null
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
                // submit button (wheels)
                //
                //
                SizedBox(
                  height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                ),
                GestureDetector(
                  onTap: () {
                    dynamic apiUrl =
                        "https://rexello.com/api/product_finder_api/get_wheels_api.php?wheel_material=$wheelMaterial&bearing_type=$bearingType&wheel_diameter=$wheelDiameter&load_carrying_capacity=$loadCarryingCapacity";
                    print("nav - $apiUrl");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesScreen(
                          getUrl: apiUrl,
                          type: 'wheels',
                          title: "",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 290,
                    margin: EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(color: Color(0xFF073358), borderRadius: BorderRadius.circular(10)),
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
    apiUrlForAjax = 'https://rexello.com/api/product_type_async_api/get_wheels_series.php';
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
  List<WheelAjaxApiModel> WheelAjaxApiModelList = [];

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
    apiUrlForAjax = 'https://rexello.com/api/product_type_async_api/get_wheels_series.php?'
        'wheel_material=$wheelMaterial'
        '&bearing_type=$bearingType'
        '&wheel_diameter=$wheelDiameter'
        '&load_carrying_capacity=$loadCarryingCapacity';
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
      // save json data to WheelAjaxApiModelList Model list
      if (jsonData is Map) {
        //
        // only add data on index 0 each time
        WheelAjaxApiModelList.insert(
          0,
          WheelAjaxApiModel(
            wheelMaterial: List<String>.from(jsonData['type']),
            bearingTypes: List<String>.from(jsonData['bearing_type']),
            wheelDiameter: List<String>.from(jsonData['wheel_diameter']),
            loadCarryingCapacity: List<String>.from(jsonData['kgs']),
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
          wheelMaterialList = (WheelAjaxApiModelList[0].wheelMaterial).cast<String>();
          bearingTypeList = (WheelAjaxApiModelList[0].bearingTypes).cast<String>();
          wheelDiameterList = (WheelAjaxApiModelList[0].wheelDiameter).cast<String>();
          loadCarryingCapacityList = (WheelAjaxApiModelList[0].loadCarryingCapacity).cast<String>();

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
class WheelAjaxApiModel {
  List wheelMaterial;
  List bearingTypes;
  List wheelDiameter;
  List loadCarryingCapacity;

  WheelAjaxApiModel({
    required this.wheelMaterial,
    required this.bearingTypes,
    required this.wheelDiameter,
    required this.loadCarryingCapacity,
  });
}
