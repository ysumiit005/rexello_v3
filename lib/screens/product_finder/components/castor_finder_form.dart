import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../globals/device_size.dart';
import '../../series_screen/series_screen.dart';
import '../custom_widgets/custom_circular_loader_on_fetch_list.dart';

class CastorFinderForm extends StatefulWidget {
  const CastorFinderForm({
    super.key,
  });

  @override
  State<CastorFinderForm> createState() => _CastorFinderFormState();
}

class _CastorFinderFormState extends State<CastorFinderForm> {
  //
  //
  // variable to save CastorAjaxApi input using bottom modal
  // var
  String? castorTypeSwivel = null;
  String? castorTypeFixed = null;
  String? castorSeries;
  String? wheelMaterial;
  //for controlling text in load capacity text box
  TextEditingController loadCarryingCapacityController = TextEditingController();
  String? wheelDiameter;
  String? wheelMaterialKey;

  //list of data
  // List<String> castorTypeList = ["Swivel", "Castor"];
  late List<String> castorSeriesList; //= ["RD1", "RD2", "RD3", "RD4", "RD5"];
  late List<String> wheelMaterialList; //= ["Cushion Tyred with Nylon Centre", "Cast Iron", "Rubber", "Thermoplastic Rubber"];
  Map<String, String> wheelMaterialMap = {
    '1': 'Cushion Tyred with Nylon Centre',
    '2': 'Cushion Tyred with PP Centre',
    '3': 'Cushioned Tyred',
    '4': 'Cushion Tyred with Yellow Lines',
    '5': 'Cast Iron',
    '6': 'Rubber',
    '7': 'Polyurethane',
    '8': 'Nylon',
    '9': 'Thermoplastic Rubber',
    '10': 'Aluminium',
    '11': 'Rubber with Polyurethane Coating',
    '12': 'Urethane High Modulus',
    '13': 'Polyurethane',
    '14': 'Nylon',
    '15': 'Nylon with Cast Iron Centre',
    '16': 'Rubber with Tread',
    '17': 'Cushion Tyred with White Hub',
    '18': 'Cushion Tyred 16'
  }; //reference map just to compare
  late Map<String?, String?> wheelMaterialMapFinal;
  // List<String> loadCarryingCapacityList = ["with break", "without break"];
  late List<String> wheelDiameterList; //= ["50", "63", "75"];

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
            if (optionTitle == "Castor Series") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: castorSeriesList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                castorSeries = castorSeriesList[index];

                                //closes modal automatic after CastorAjaxApi selects option in modal
                                Navigator.pop(context);
                              });

                              //
                              fetchListDataAll();
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(castorSeriesList[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (optionTitle == "Wheel Material") {
              return Column(
                children: [
                  Text(
                    optionTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: wheelMaterialMapFinal.length,
                      itemBuilder: (context, index) {
                        final keys = wheelMaterialMapFinal.keys.toList();
                        final values = wheelMaterialMapFinal.values.toList();
                        final key = keys[index]; // keys only to map
                        final value = values[index]; // required values
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                wheelMaterial = value;
                                String? wheelMaterialKey = key;

                                //closes modal automatic after CastorAjaxApi selects option in modal
                                Navigator.pop(context);
                              });

                              //
                              fetchListDataAll();
                            },
                            splashColor: Colors.amber,
                            child: ListTile(
                              title: Text(value!),
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

                                //closes modal automatic after CastorAjaxApi selects option in modal
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
// variable for switching castor type ui colors from swivel to fixed
//
  Color swivelBgColor = Color(0xFF073358);
  Color swivelFontColor = Colors.white;

  Color fixedBgColor = Colors.white;
  Color fixedFontColor = Colors.black;

  //
  // textform field only take numbers
  //
  final TextInputFormatter _numberFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);

    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 30),
            child: Column(
              children: [
                SizedBox(
                  height: DeviceSize.height * (35 / DeviceSize.figmascreensizeHeight),
                ),
                //
                //
                // castor type with switch buttons
                //
                //
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: const Text(
                        "Castors Types : ",
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
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  swivelBgColor = Color(0xFF073358);
                                  swivelFontColor = Colors.white;
                                  fixedBgColor = Colors.white;
                                  fixedFontColor = Colors.black;

                                  //save CastorAjaxApiInput in var
                                  castorTypeSwivel = "1";
                                  castorTypeFixed = null;
                                  print(castorTypeSwivel);
                                });

                                //
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
                                    color: swivelBgColor
                                    // Color(0xFF073358),
                                    ),
                                child: Center(
                                    child: Text(
                                  'Swivel',
                                  style: TextStyle(
                                    color: swivelFontColor,
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
                                  swivelBgColor = Colors.white;
                                  swivelFontColor = Colors.black;
                                  fixedBgColor = const Color(0xFF073358);
                                  fixedFontColor = Colors.white;

                                  //save CastorAjaxApiInput in var
                                  castorTypeFixed = "1";
                                  castorTypeSwivel = null;
                                  print(castorTypeFixed);
                                });

                                //
                                fetchListDataAll();
                              },
                              child: Container(
                                height: 49,
                                width: 145,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: fixedBgColor,
                                ),
                                child: Center(
                                    child: Text(
                                  'Fixed',
                                  style: TextStyle(
                                    fontFamily: 'Exo_2',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: fixedFontColor,
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

                //
                //
                // Select Material :
                //
                //
                SizedBox(
                  height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        "Castor Series :",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    //
                    // text Input
                    //
                    GestureDetector(
                      onTap: () {
                        _showBottomDrawer1(context, "Castor Series");
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
                                      castorSeries ?? "Eg. RD1 or RD5",
                                      style: const TextStyle(
                                        color: Color(0xFF706C6C),
                                      ),
                                    )),
                              ),
                              //
                              // clear icon or cancel
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    castorSeries = null;
                                  });

                                  //
                                  fetchListDataAll();
                                },
                                child: Container(
                                  width: 60,
                                  height: double.infinity,
                                  // color: Colors.yellow,
                                  child: castorSeries != null
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
                //
                //
                // Wheel material :
                //
                //
                SizedBox(
                  height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        "Wheel Material : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                                      wheelMaterial ?? "Eg. Cast Iron",
                                      style: const TextStyle(
                                        color: Color(0xFF706C6C),
                                      ),
                                    )),
                              ),
                              //
                              // clear icon or cancel
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wheelMaterial = null;
                                    wheelMaterialKey = null;
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
                //
                //
                // Load Carrying Capacity  :
                //
                //
                SizedBox(
                  height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        "Load Carrying Capacity  : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: 295,
                      height: 45,
                      margin: const EdgeInsets.only(left: 25),
                      padding: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(25, 37, 136, 0.15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                inputFormatters: [
                                  _numberFormatter
                                ], // only accepts number from keyboard , dont let CastorAjaxApi enter letter if did it filters it
                                controller: loadCarryingCapacityController,

                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "In kgs",
                                    hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
                              ),
                            ),
                          ),
                          //
                          // clear icon or cancel
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                loadCarryingCapacityController.text = "";
                              });

                              //
                              fetchListDataAll();
                            },
                            child: Container(
                              width: 60,
                              height: double.infinity,
                              // color: Colors.yellow,
                              child: loadCarryingCapacityController.text != ""
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
                  ],
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
                        margin: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          "Wheel Diameter : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus(); // solves the keyboard opening on back button clicked
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
                                        wheelDiameter ?? "In mm",
                                        style: const TextStyle(
                                          color: Color(0xFF706C6C),
                                        ),
                                      )),
                                ),
                                //
                                // clear icon or cancel
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
                // sumit button (castors)
                //
                //
                SizedBox(
                  height: DeviceSize.height * (30 / DeviceSize.figmascreensizeHeight),
                ),
                GestureDetector(
                  onTap: () {
                    dynamic apiUrl = 'https://rexello.com/api/product_finder_api/get_castors_api.php?'
                        'castor_type_swivel=$castorTypeSwivel'
                        '&castor_type_fixed=$castorTypeFixed'
                        '&castor_series=$castorSeries'
                        '&castor_material=$wheelMaterialKey'
                        '&wheel_diameter=$wheelDiameter'
                        '&load_carrying_capacity=${loadCarryingCapacityController.text}';
                    print(apiUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesScreen(
                          getUrl: apiUrl,
                          type: 'castors',
                          title: "",
                        ),
                      ),
                    );
                  }, //
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
    apiUrlForAjax = 'https://rexello.com/api/product_type_async_api/get_castor_series.php';
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

  //////////////////////////////////////
  //
  //  normal funct
  //
  //
  // converts list to map for wheel materials
  Map<String?, String?> mapValues(List<String?> list, Map<String?, String?> map) {
    Map<String?, String?> resultMap = {};
    for (String? key in list) {
      if (map.containsKey(key)) {
        resultMap[key] = map[key];
      }
    }
    return resultMap;
  }

  ////////////////////////////////////////////////////////////////////////////////////
  //
  // db function
  //
  //
  //
  List<CastorAjaxApi> CastorAjaxApiList = [];

  //
  // ajax like function to load form options list
  /////////////////////////////////
  Future<void> fetchListDataAll() async {
    //
    // show loader to pause user interaction untill data is fetched
    //
    dataListLoadingFromApi = true;

    //
    // shoots url with input to api
    //
    apiUrlForAjax = 'https://rexello.com/api/product_type_async_api/get_castor_series.php?'
        'series_name=$castorSeries'
        '&wheel_options=$wheelMaterialKey'
        '&wheel_diameter=$wheelDiameter'
        '&castor_type_swivel=$castorTypeSwivel'
        '&castor_type_fixed=$castorTypeFixed'
        '&load_carrying_capacity=${loadCarryingCapacityController.text}';
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
      // save json data to CastorAjaxApiList Model list
      if (jsonData is Map) {
        //
        // only add data on index 0 each time
        CastorAjaxApiList.insert(
          0,
          CastorAjaxApi(
            castorTypeSwivel: (jsonData['type_swivel']),
            castorTypeFixed: (jsonData['type_fixed']),
            castorSeries: List<String>.from(jsonData['series_name']),
            wheelMaterial: List<String>.from(jsonData['material']),
            wheelDiameter: List<String>.from(jsonData['diameter']),
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
          // castorTypeSwivel = (CastorAjaxApiList[0].castorTypeSwivel);
          // castorTypeFixed = (CastorAjaxApiList[0].castorTypeFixed);
          castorSeriesList = (CastorAjaxApiList[0].castorSeries).cast<String>();
          wheelMaterialList = (CastorAjaxApiList[0].wheelMaterial).cast<String>();
          wheelMaterialMapFinal = mapValues(wheelMaterialList, wheelMaterialMap);
          wheelDiameterList = (CastorAjaxApiList[0].wheelDiameter).cast<String>();
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
class CastorAjaxApi {
  int? castorTypeSwivel;
  int? castorTypeFixed;
  List castorSeries;
  List wheelMaterial;
  List wheelDiameter;

  CastorAjaxApi({
    required this.castorTypeSwivel,
    required this.castorTypeFixed,
    required this.castorSeries,
    required this.wheelMaterial,
    required this.wheelDiameter,
  });
}
