import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../globals/custom_app_bar.dart';
import '../../globals/device_size.dart';
import '../../models/req_quote.dart';
import 'package:http/http.dart' as http;

import '../drawer/custom_drawer.dart';

//temp delete or comment later
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DetailScreen(description: '', heroId: 1, image: '', title: '', weight: ''),
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Inter', // Replace with your desired font family
          ),
        ),
      ),
    );
  }
}

//
// starts below
//
class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.title,
    required this.weight,
    required this.image,
    required this.description,
    required this.heroId,
    this.type,
  });

  final String title, weight, image, description;
  final int heroId;
  final String? type;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //
  //
  // for right to left drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;
  late ScrollController _scrollControllerVertical;
  final GlobalKey _containerKey = GlobalKey(); //for scroll to particular text vertically

  String get getTitle => widget.title;
  String get getWeight => widget.weight;
  String get getImage => widget.image;
  String get getDescription => widget.description;
  int get getHeroId => widget.heroId;
  String? get getType => widget.type;

  @override
  void initState() {
    super.initState();

    //init scroll controller else error
    _scrollController = ScrollController();
    _scrollControllerVertical = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerVertical.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _handleSubmit() {
    setState(() {
      _isLoading = true;
    });

    // Simulating an asynchronous operation
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  //
  //
  // for expand controact description toggle
  bool isExpanded = false;
  String readMoreOrLess = "Read More ...";
  int stepper = 1;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (readMoreOrLess == " Read Less") {
        readMoreOrLess = " Read More ...";
      } else {
        readMoreOrLess = " Read Less";
      }
    });
  }

  void _scrollToContainer2() {
    _scrollController.animateTo(
      MediaQuery.of(context).size.width, // Scroll to the width of Container 2
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToContainer1() {
    _scrollController.animateTo(
      0, // Scroll to the width of Container 2
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  //
  // show preview ui above main ui using stack
  //
  bool showOverlay = false;
  void toggleOverlay() async {
    //close keyboard if opened
    FocusScope.of(context).unfocus();

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      showOverlay = !showOverlay;
    });
  }

  // this wont await for keyboard to close and will act quick
  void toggleOverlayWithoutAwait() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      showOverlay = !showOverlay;
    });
  }

  //
  //
  // variable to save user input using bottom modal
  // var
  /// castor
  String castorName = "";
  String castorType = "";
  String castorBrakeType = "";
  String castorWheelMaterial = "";
  String castorWheelSize = "";
  String castorTopFixtures = "";
  String quantity = "1";

  /// wheels
  String wheelName = "";
  String wheelDiameter = "";
  String wheelTreadWidth = "";
  // trolleys
  String trolleyName = "";
  // others
  String othersName = "";
  //user detail
  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userMessage = TextEditingController();
  TextEditingController productQuantityController = TextEditingController(text: "1");

  //list of data
  // List<String> castorNameList = ["1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3"];
  /// castor
  List<String> castorTypeList = ["Swivel", "Castor"];
  List<String> castorBrakeTypeList = ["With break", "Without break"];
  List<String> castorWheelMaterialList = [
    'Cushion Tyred with Nylon Centre',
    'Cushion Tyred with PP Centre',
    'Cushioned Tyred',
    'Cushion Tyred with Yellow Lines',
    'Cast Iron',
    'Rubber',
    'Polyurethane',
    'Nylon',
    'Thermoplastic Rubber',
    'Aluminium',
    'Rubber with Polyurethane Coating',
    'Urethane High Modulus',
    'Polyurethane',
    'Nylon',
    'Nylon with Cast Iron Centre',
    'Rubber with Tread',
    'Cushion Tyred with White Hub',
    'Cushion Tyred 16"'
  ];

  List<String> castorWheelSizeList = [
    "25mm x 12mm",
    "31mm x 15mm",
    "38mm x 20mm",
    "50mm x 22mm",
    "38mm x 20mm",
    "50mm x 20mm",
    "50mm x 22mm",
    "63mm x 22mm",
    "75mm x 22mm",
    "100mm x 22mm",
    "63mm x 28mm",
    "75mm x 28mm",
    "100mm x 28mm",
    "125mm x 28mm",
    "75mm x 38mm",
    "100mm x 38mm",
    "125mm x 38mm",
    "150mm x 50mm",
    "200mm x 50mm",
    "50mm",
    "50mm x 22mm",
    "63mm x 22mm",
    "75mm x 22mm",
    "50mm x 22mm",
    "63mm x 22mm",
    "75mm x 22mm",
    "50mm x 22mm",
    "75mm x 22mm",
    "125mm x 22mm",
    "25mm x 12mm",
    "63mm x 22mm",
    "31mm x 15mm",
    "38mm x 20mm",
    "50mm x 22mm",
    "63mm x 22mm",
    "75mm x 22mm",
    "50mm x 20mm",
    "63mm x 22mm",
    "75mm x 22mm",
    "100mm x 22mm",
    "38mm",
    "50mm",
    "63mm",
    "150mm x 25mm",
    "200mm x 31mm",
    "63mm x 38mm",
    "125mm x 38mm",
    "75mm x 38mm",
    "75mm x 22mm",
    "100mm x 50mm",
    "125mm x 50mm",
    "75mm x 31mm",
    "100mm x 31mm",
    "125mm x 31mm",
    "150mm x 31mm",
    "80mm x 40mm",
    "100mm x 40mm",
    "125mm x 40mm",
    "100mm x 50mm"
  ];
  List<String> castorTopFixturesList = [
    "PLATE TOP FIXTURE",
    "BLIND HOLE TOP FIXTURE",
    "SOLID PLUG TOP FIXTURE",
    "KING PIN TOP FIXTURE",
    "THREADED PIN TOP FIXTURE",
    "Scafolding"
  ];

  ///wheels
  List<String> wheelDiameterList = [
    "50",
    "63",
    "63",
    "75",
    "75",
    "75",
    "80",
    "100",
    "100",
    "100",
    "100",
    "125",
    "125",
    "125",
    "125",
    "150",
    "150",
    "150",
    "160",
    "200",
    "200"
  ];
  List<String> wheelTreadWidthList = [
    "22",
    "22",
    "28",
    "22",
    "28",
    "31",
    "40",
    "22",
    "28",
    "38",
    "40",
    "28",
    "31",
    "38",
    "50",
    "25",
    "31",
    "50",
    "40",
    "25",
    "50"
  ];

  void _showBottomDrawer1(BuildContext context, String optionTitle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
      builder: (BuildContext context) {
        if (optionTitle == "Series Name") {
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
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          );
        } else if (optionTitle == "Castor Type") {
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
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: castorTypeList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              castorType = castorTypeList[index];
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
                          },
                          splashColor: Colors.amber,
                          child: ListTile(
                            title: Text(castorTypeList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (optionTitle == "Brake Type") {
          // bottom modal UI for
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: castorBrakeTypeList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              castorBrakeType = castorBrakeTypeList[index];
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
                          },
                          splashColor: Colors.amber,
                          child: ListTile(
                            title: Text(castorBrakeTypeList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (optionTitle == "Wheel Material") {
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
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: castorWheelMaterialList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              castorWheelMaterial = castorWheelMaterialList[index];
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
                          },
                          splashColor: Colors.amber,
                          child: ListTile(
                            title: Text(castorWheelMaterialList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (optionTitle == "Wheel Size") {
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
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: castorWheelSizeList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              castorWheelSize = castorWheelSizeList[index];
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
                          },
                          splashColor: Colors.amber,
                          child: ListTile(
                            title: Text(castorWheelSizeList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (optionTitle == "Top Fixtures") {
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
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: castorTopFixturesList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              castorTopFixtures = castorTopFixturesList[index];
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
                          },
                          splashColor: Colors.amber,
                          child: ListTile(
                            title: Text(castorTopFixturesList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (optionTitle == "Wheel Diameter") {
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
            child: Column(
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
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
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
            ),
          );
        } else if (optionTitle == "Tread With") {
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
            child: Column(
              children: [
                Text(
                  optionTitle,
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: wheelTreadWidthList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              wheelTreadWidth = wheelTreadWidthList[index];
                              //closes modal automatic after user selects option in modal
                              Navigator.pop(context);
                            });
                          },
                          splashColor: Colors.amber,
                          child: ListTile(
                            title: Text(wheelTreadWidthList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
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
            child: const Center(
              child: Text(
                "Some Issue See If Else Block : string passed from ui dont match if condition string",
                style: TextStyle(fontSize: 11),
              ),
            ),
          );
        }
      },
    );
  }

  //
  //// validation logic
  //

  bool isUserNameValid = true;
  bool isUserPhoneNoValid = true;
  bool isUserEmailValid = true;
  bool isUserAddressValid = true;
  bool isUserMessageValid = true;
  bool isValidFlag = true;

  //for email validation

  bool _isFormValid() {
    //
    // check username
    if (userName.text.isEmpty || userName.text == "") {
      setState(() {
        isUserNameValid = false;
        isValidFlag = false;
      });
    } else {
      setState(() {
        isUserNameValid = true;
        isValidFlag = true;
      });
    }
    //
    // check phone number
    if (userPhone.text.isEmpty || userPhone.text == "" || !RegExp(r'^\d{10}$').hasMatch(userPhone.text)) {
      setState(() {
        isUserPhoneNoValid = false;
        isValidFlag = false;
      });
    } else {
      setState(() {
        isUserPhoneNoValid = true;
        isValidFlag = true;
      });
    }
    //
    // check email
    if (userEmail.text.isEmpty ||
        userEmail.text == "" ||
        !RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$').hasMatch(userEmail.text)) {
      setState(() {
        isUserEmailValid = false;
        isValidFlag = false;
      });
    } else {
      setState(() {
        isUserEmailValid = true;
        isValidFlag = true;
      });
    }
    // //
    // // check address
    // if (userAddress.text.isEmpty || userAddress.text == "") {
    //   setState(() {
    //     isUserAddressValid = false;
    //     isValidFlag = false;
    //   });
    // } else {
    //   setState(() {
    //     isUserAddressValid = true;
    //     isValidFlag = true;
    //   });
    // }
    // //
    // // check message
    // if (userMessage.text.isEmpty || userMessage.text == "") {
    //   setState(() {
    //     isUserMessageValid = false;
    //     isValidFlag = false;
    //   });
    // } else {
    //   setState(() {
    //     isUserMessageValid = true;
    //     isValidFlag = true;
    //   });
    // }

    //
    // check if all field are valid , if yes make isValidFlag to true else false
    if (isUserNameValid && isUserPhoneNoValid && isUserEmailValid /* && isUserAddressValid && isUserMessageValid */) {
      isValidFlag = true;
    } else {
      isValidFlag = false;
    }
    // alas if all corrct then form is valid
    //
    // print("userNameValid = $isUserNameValid, userPhone = $isUserPhoneNoValid"
    //     " userEmail = $isUserEmailValid"
    //     " userAddress = $isUserAddressValid"
    //     " userMessage = $isUserMessageValid"
    //     " isValidFlag = $isValidFlag");
    return isValidFlag;
  }

  //
  //
  // send data to db req quote table
  //
  //
  bool _isButtonDisabled = false;

  void insertInDb() async {
    //close keyboard if opened
    FocusScope.of(context).unfocus();
    // disable submit button to prevent more than 1 submit at a time
    _handleSubmit();
    setState(() {
      _isButtonDisabled = true;
    });

    //
    // if form validation is wrong show snackbar
    if (_isFormValid() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 30,
            child: const Center(
              child: Text('Please enter required fields correctly.'),
            ),
          ),
        ),
      );
    }

    //
    // if form validation is CORRECT - save to db
    if (_isFormValid()) {
      //
      //check if url connection done sucessfully
      bool anyError = true;

      String apiUrl = "https://rexello.com/api/save_req_to_db.php?"
          "castorName=${castorName}&"
          "castorType=${castorType}&"
          "castorBrakeType=${castorBrakeType}&"
          "castorWheelMaterial=${castorWheelMaterial}&"
          "castorWheelSize=${castorWheelSize}&"
          "castorTopFixtures=${castorTopFixtures}&"
          "quantity=${quantity}&"
          "wheelName=${wheelName}&"
          "wheelDiameter=${wheelDiameter}&"
          "wheelTreadWidth=${wheelTreadWidth}&"
          "trolleyName=${trolleyName}&"
          "othersType=${othersName}&"
          "userProductType=na&"
          "userApplicationType=na&"
          "userName=${userName.text}&"
          "userPhone=${userPhone.text}&"
          "userEmail=${userEmail.text}&"
          "userAddress=${userAddress.text}&"
          "userMessage=${userMessage.text}&"
          "userWebsite=na";
      try {
        await http.get(Uri.parse(apiUrl));
        anyError = false;
      } catch (e) {
        if (e.toString() == "XMLHttpRequest error.") {
          print("added data to db");
          anyError = false;
        }
      }

      if (anyError) {
        const snackBar = SnackBar(
          content: Text("Some Error Occured"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        isUserDataSaved = true;
        await Future.delayed(const Duration(seconds: 3)); //success will be visible for thsi duration
        isUserDataSaved = false;
      }
    }

    setState(() {
      _isButtonDisabled = false;
    });
  }

  // is user data saved to db check
  bool isUserDataSaved = false;

  //
  // textform field only take numbers
  //
  final TextInputFormatter _numberFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  // main ui
  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);

    if (getType == "castors") {
      castorName = getTitle;
    }
    if (getType == "wheels") {
      wheelName = getTitle;
    }
    if (getType == "trolleys") {
      trolleyName = getTitle;
    }
    if (getType == "others") {
      othersName = getTitle;
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            //
            // main code
            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // custom appbar opens drawer right to left
                //
                CustomAppBar(
                  scaffoldKey: _scaffoldKey,
                  title: "",
                ),

                //
                // content details
                //
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      controller: _scrollControllerVertical,
                      child: Column(
                        children: [
                          //
                          // product image
                          //
                          Container(
                            width: DeviceSize.width,
                            height: 280,
                            color: const Color(0xFFECE8E8),
                            child: Center(
                              child: SizedBox(
                                height: 180,
                                child: Hero(
                                  tag: getHeroId,
                                  child: Image.network(getImage),
                                ),
                              ),
                            ),
                          ),
                          //
                          // Title and description
                          //
                          Container(
                            width: DeviceSize.width,
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: DeviceSize.width,
                                  height: 10,
                                  // color: Color(0xFFFFFFFF),
                                ),
                                // title
                                SizedBox(
                                  height: 72,
                                  width: DeviceSize.width,
                                  // color: Color(0xFF807C7C),
                                  child: Center(
                                      child: Text(getTitle,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ))),
                                ),
                                // description title text
                                SizedBox(
                                  height: 50,
                                  width: DeviceSize.width,
                                  // color: Color(0xFF807C7C),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF073358),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: DeviceSize.width,
                                  padding: const EdgeInsets.only(bottom: 25),
                                  // color: Color(0xFF807C7C),
                                  child: Column(
                                    children: [
                                      Text(
                                        getDescription,
                                        maxLines: isExpanded ? 25 : 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          fontFamily: 'Inter',
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            color: const Color.fromRGBO(255, 255, 255, 1),
                                            padding: const EdgeInsets.only(left: 5),
                                            child: GestureDetector(
                                              onTap: toggleExpand,
                                              child: getDescription.length > 100
                                                  ? Text(
                                                      readMoreOrLess,
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12,
                                                        fontFamily: 'Inter',
                                                      ),
                                                    )
                                                  : const Text(""),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //
                          // request quote form
                          //
                          Container(
                            key: _containerKey,
                            width: DeviceSize.width,
                            height: 750,
                            color: const Color(0xFF807C7C),
                            child: Scrollbar(
                              thumbVisibility: false,
                              controller: _scrollController,
                              thickness: 1,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _scrollController,
                                child: Row(
                                  children: [
                                    //
                                    // request quote form - 1
                                    //
                                    if (getType == "castors") requestAQuoteMethodCastors(context),
                                    if (getType == "wheels") requestAQuoteMethodWheels(context),
                                    if (getType == "trolleys") requestAQuoteMethodTrolleys(context),
                                    if (getType == "others") requestAQuoteMethodOtherProducts(context),
                                    //
                                    //
                                    // request quote form - 2 technical
                                    //
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(horizontal: 50),
                                      // color: Colors.blue,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/background1.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          // request quote
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          const Center(
                                            child: Text(
                                              "Request a Quote",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Color(0xFF073358),
                                              ),
                                            ),
                                          ),

                                          // name box
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 45,
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            decoration: BoxDecoration(
                                              border: isUserNameValid ? null : Border.all(color: Colors.red, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                              color: const Color.fromRGBO(25, 37, 136, 0.15),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextFormField(
                                                controller: userName,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(30),
                                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                                                ],
                                                onChanged: (value) {
                                                  //
                                                  // check username
                                                  if (userName.text.isEmpty || userName.text == "") {
                                                    setState(() {
                                                      isUserNameValid = false;
                                                    });
                                                    isValidFlag = false;
                                                  } else {
                                                    setState(() {
                                                      isUserNameValid = true;
                                                    });
                                                  }
                                                },
                                                // keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  hintText: "Name *",
                                                  hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          //phone number
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 45,
                                            padding: const EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              border: isUserPhoneNoValid ? null : Border.all(color: Colors.red, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                              color: const Color.fromRGBO(25, 37, 136, 0.15),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextFormField(
                                                inputFormatters: [
                                                  _numberFormatter,
                                                  LengthLimitingTextInputFormatter(10),
                                                ], // only accepts number from keyboard , dont let user enter letter if did it filters it
                                                onChanged: (value) {
                                                  //
                                                  // check phone number
                                                  if (userPhone.text.isEmpty || userPhone.text == "") {
                                                    setState(() {
                                                      isUserPhoneNoValid = false;
                                                    });
                                                  } else {
                                                    // inner if else to validate email format
                                                    if (!RegExp(r'^\d{10}$').hasMatch(userPhone.text)) {
                                                      setState(() {
                                                        isUserPhoneNoValid = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        isUserPhoneNoValid = true;
                                                      });
                                                    }
                                                  }
                                                },
                                                controller: userPhone,
                                                keyboardType: TextInputType.number,
                                                decoration: const InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: "Phone Number *",
                                                    hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // email box
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 45,
                                            padding: const EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              border: isUserEmailValid ? null : Border.all(color: Colors.red, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                              color: const Color.fromRGBO(25, 37, 136, 0.15),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextFormField(
                                                controller: userEmail,
                                                onChanged: (value) {
                                                  //
                                                  // check email
                                                  if (userEmail.text.isEmpty || userEmail.text == "") {
                                                    setState(() {
                                                      isUserEmailValid = false;
                                                    });
                                                  } else {
                                                    final RegExp emailRegex =
                                                        RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

                                                    // inner if else to validate email format
                                                    if (!emailRegex.hasMatch(userEmail.text)) {
                                                      setState(() {
                                                        isUserEmailValid = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        isUserEmailValid = true;
                                                      });
                                                    }
                                                  }
                                                },
                                                decoration: const InputDecoration(
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  hintText: "Email *",
                                                  hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // email not correct prompt
                                          //
                                          if (isUserEmailValid == false)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Invalid E-mail Format",
                                                  style: TextStyle(color: Colors.red, fontSize: 10),
                                                ),
                                              ),
                                            ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // company address
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 100,
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              bottom: 5,
                                              right: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              border: isUserAddressValid ? null : Border.all(color: Colors.red, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                              color: const Color.fromRGBO(25, 37, 136, 0.15),
                                            ),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: TextFormField(
                                                controller: userAddress,
                                                onChanged: (value) {
                                                  // //
                                                  // // check address
                                                  // if (userAddress.text.isEmpty || userAddress.text == "") {
                                                  //   setState(() {
                                                  //     isUserAddressValid = false;
                                                  //   });
                                                  // } else {
                                                  //   setState(() {
                                                  //     isUserAddressValid = true;
                                                  //   });
                                                  // }
                                                },
                                                maxLines: 5,
                                                maxLength: 100,
                                                decoration: const InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: "Company Address",
                                                    hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // send us a message
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 100,
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              bottom: 5,
                                              right: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              border: isUserMessageValid ? null : Border.all(color: Colors.red, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                              color: const Color.fromRGBO(25, 37, 136, 0.15),
                                            ),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: TextFormField(
                                                controller: userMessage,
                                                onChanged: (value) {
                                                  //
                                                  // check message
                                                  if (userMessage.text.isEmpty || userMessage.text == "") {
                                                    setState(() {
                                                      isUserMessageValid = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isUserMessageValid = true;
                                                    });
                                                  }
                                                },
                                                maxLines: 5,
                                                maxLength: 200,
                                                decoration: const InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: "Send Us a Message",
                                                    hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
                                              ),
                                            ),
                                          ),

                                          //
                                          // buttons
                                          //
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              //
                                              // prev button - previous
                                              //
                                              GestureDetector(
                                                onTap: _scrollToContainer1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: const Color.fromRGBO(64, 60, 254, 0.8),
                                                  ),
                                                  height: 45,
                                                  width: 115,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 45,
                                                        width: 35,
                                                        child: Align(
                                                          alignment: Alignment.centerRight,
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            padding: const EdgeInsets.all(2),
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                                                            child: const Icon(
                                                              Icons.arrow_back_ios_new,
                                                              color: Color(0xff6562FD),
                                                              size: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Flexible(
                                                        child: Center(
                                                          child: Text(
                                                            'Prev',
                                                            style: TextStyle(fontSize: 15, color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //
                                              // preview button
                                              //
                                              SizedBox(
                                                height: 45,
                                                width: 115,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(
                                                      const Color(0xFF000000),
                                                    ),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10), // Adjust the value as needed
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: toggleOverlay,
                                                  child: const Text(
                                                    'Preview',
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //
                                          // Submit Button
                                          //
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: _isButtonDisabled ? null : insertInDb,
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: const Color(0xFFFF0707),
                                              ),
                                              child: _isLoading
                                                  ? const Center(
                                                      child: SizedBox(
                                                        height: 25,
                                                        width: 25,
                                                        child: CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2.0,
                                                        ),
                                                      ),
                                                    )
                                                  : const Center(
                                                      child: Text(
                                                        "Submit",
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 100),
                                              curve: Curves.decelerate,
                                              height: isUserDataSaved ? 50 : 0,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.green,
                                              ),
                                              child: const Center(
                                                child: Text("Success"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //
                          // banners for castors
                          //

                          //
                          // swivel castors
                          Container(
                            width: DeviceSize.width,
                            // height: 350,
                            padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
                            color: const Color(0xFF073358),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                const Text(
                                  "Swivel Castors",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                // dash below title
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 90,
                                      color: const Color.fromRGBO(255, 17, 0, 1),
                                    ),
                                  ],
                                ),
                                // image
                                Center(
                                  child: Container(
                                      height: 130,
                                      margin: const EdgeInsets.symmetric(vertical: 15),
                                      child: Image.network("https://rexello.com/images/castors/RD2.webp")),
                                ),

                                // description
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: const Text(
                                    "Check out our new RD2 series castor with Swivel Castor Type from Rexello Castors Pvt-ltd. \n\nThe RD2 series castor with Swivel Castor Type comes in with various top fixture and wheel material. We provide customize solution to ensure that it fits your application perfectly.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  // color: Colors.amber,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // req quote button
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        //
                                        // animate to req quote 1
                                        _scrollToContainer1();
                                        //
                                        // scroll to reqaquote container
                                        Scrollable.ensureVisible(
                                          _containerKey.currentContext!,
                                          duration: const Duration(milliseconds: 350),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Request Quote",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          //
                          // Brake castors
                          Container(
                            width: DeviceSize.width,
                            // height: 350,
                            padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
                            color: const Color(0xFFE21E23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                const Text(
                                  "Brake Castors",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                // dash below title
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 90,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ],
                                ),
                                // image
                                Center(
                                    child: Container(
                                        height: 130,
                                        margin: const EdgeInsets.symmetric(vertical: 15),
                                        child: Image.network("https://rexello.com/images/castors/AR%20TW.webp"))),
                                // description
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: const Text(
                                    "Check out our new RD2 series castor with Swivel Castor Type from Rexello Castors Pvt-ltd. \n\nThe RD2 series castor with Swivel Castor Type comes in with various top fixture and wheel material. We provide customize solution to ensure that it fits your application perfectly.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // req quote button
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        //
                                        // animate to req quote 1
                                        _scrollToContainer1();
                                        //
                                        // scroll to reqaquote container
                                        Scrollable.ensureVisible(
                                          _containerKey.currentContext!,
                                          duration: const Duration(milliseconds: 350),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Request Quote",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //
            // show overlay code - preview box overlay
            //
            if (showOverlay && getType == "castors") previewBoxOverlayCastor(context),
            if (showOverlay && getType == "wheels") previewBoxOverlayWheels(context),
            if (showOverlay && getType == "trolleys") previewBoxOverlayTrollies(context),
            if (showOverlay && getType == "others") previewBoxOverlayOtherProducts(context),
          ],
        ),
      ),
      endDrawer: const CustomDrawer(),
    );

    //
    //
    // var
    //
    //

    //
    //
    // db function
    //
    //
  }

//
//
//
// preview box shown for type castors
//
//
//
  GestureDetector previewBoxOverlayCastor(BuildContext context) {
    return GestureDetector(
      // onTap: toggleOverlayWithoutAwait,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            height: DeviceSize.height * 0.75,
            width: DeviceSize.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: toggleOverlayWithoutAwait,
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 10),
                            // color:Colors.amber,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //
                  // text product
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Product",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$castorName"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFDFDFDF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("$quantity"),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Castor Type",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$castorType"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Brake Type",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$castorBrakeType"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Wheel Material",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$castorWheelMaterial"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Wheel Size",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$castorWheelSize"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Top Fixtures",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$castorTopFixtures"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  // submit button in preview
                  //
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: _isButtonDisabled ? null : insertInDb,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFF0707),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.decelerate,
                      height: isUserDataSaved ? 50 : 0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text("Success"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//
//
//
// preview box shown for type wheels
//
//
//
  GestureDetector previewBoxOverlayWheels(BuildContext context) {
    return GestureDetector(
      // onTap: toggleOverlayWithoutAwait,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            height: DeviceSize.height * 0.75,
            width: DeviceSize.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: toggleOverlayWithoutAwait,
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 10),
                            // color:Colors.amber,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //
                  // text product
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Product",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$wheelName"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFDFDFDF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("$quantity"),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Wheel Diameter",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$wheelDiameter"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Tread With",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$wheelTreadWidth"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //
                  // submit button in preview
                  //
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: _isButtonDisabled ? null : insertInDb,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFF0707),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                      height: isUserDataSaved ? 50 : 0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text("Success"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//
//
//
// preview box shown for type castors
//
//
//
  GestureDetector previewBoxOverlayTrollies(BuildContext context) {
    return GestureDetector(
      // onTap: toggleOverlayWithoutAwait,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            height: DeviceSize.height * 0.75,
            width: DeviceSize.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: toggleOverlayWithoutAwait,
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 10),
                            // color:Colors.amber,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //
                  // text product
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Product",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$trolleyName"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  // quantity
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFDFDFDF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("$quantity"),
                          ),
                        )
                      ],
                    ),
                  ),

                  //
                  // submit button in preview
                  //
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: _isButtonDisabled ? null : insertInDb,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFF0707),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                      height: isUserDataSaved ? 50 : 0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text("Success"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//
//
//
// preview box shown for type other products
//
//
//
  GestureDetector previewBoxOverlayOtherProducts(BuildContext context) {
    return GestureDetector(
      // onTap: toggleOverlayWithoutAwait,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            height: DeviceSize.height * 0.75,
            width: DeviceSize.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: toggleOverlayWithoutAwait,
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 10),
                            // color:Colors.amber,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //
                  // text product
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Product",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            constraints: BoxConstraints(
                              minHeight: 25, // Replace with your desired minimum height
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFDFDF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$othersName"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            child: const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFDFDFDF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("$quantity"),
                          ),
                        )
                      ],
                    ),
                  ),

                  //
                  // submit button in preview
                  //
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: _isButtonDisabled ? null : insertInDb,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFF0707),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                      height: isUserDataSaved ? 50 : 0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text("Success"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//
//
//
// req quote form for castors
//
//
//
  Container requestAQuoteMethodCastors(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      // color: Colors.blue,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // request quote
          //
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Text(
              "Request a Quote",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF073358),
              ),
            ),
          ),

          // series name box
          //
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Series Name : $getTitle",
                  style: const TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                )),
          ),

          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Castor Type");
            },
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
                        "Castor Type : $castorType",
                        style: TextStyle(
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
                        castorType = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: castorType != ""
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

          const SizedBox(
            height: 20,
          ),
          // brake type
          //
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Brake Type");
            },
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
                          "Brake Type : $castorBrakeType",
                          style: TextStyle(
                            color: Color(0xFF706C6C),
                          ),
                        )),
                  ),
                  //
                  // clear icon
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        castorBrakeType = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: castorBrakeType != ""
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

          const SizedBox(
            height: 20,
          ),
          // wheel material
          //
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Wheel Material");
            },
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
                          "Wheel Material : $castorWheelMaterial",
                          style: TextStyle(
                            color: Color(0xFF706C6C),
                          ),
                        )),
                  ),
                  //
                  // clear icon
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        castorWheelMaterial = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: castorWheelMaterial != ""
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

          const SizedBox(
            height: 20,
          ),
          // wheel size
          //
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Wheel Size");
            },
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
                          "Wheel Size : $castorWheelSize",
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
                        castorWheelSize = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: castorWheelSize != ""
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

          const SizedBox(
            height: 20,
          ),

          // top fixtures
          //
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Top Fixtures");
            },
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
                          "Top Fixtures : \n$castorTopFixtures",
                          style: TextStyle(
                            color: Color(0xFF706C6C),
                            fontSize: 12.5,
                          ),
                        )),
                  ),
                  //
                  // clear icon
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        castorTopFixtures = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: castorTopFixtures != ""
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

          const SizedBox(
            height: 20,
          ),
          //
          // quantity
          //
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quantity",
                  style: TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                ),
                Container(
                  // color: Colors.grey,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  //
                  // stepper counter adder + -
                  //
                  child: Row(
                    children: [
                      //
                      // minus sign
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (stepper > 1) {
                              stepper--;
                              productQuantityController.text = stepper.toString();
                              print(quantity);
                              quantity = productQuantityController.text;
                            }
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF403CFE),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // Ui box to show quantity
                      //
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                        child: Center(child: Text("$stepper")),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // add icon
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            stepper++;
                            quantity = stepper.toString();
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFEDEAFD),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //
          // button for scroll to next screen
          //
          const SizedBox(
            height: 20,
          ),
          //
          // Next Button for slide to next form
          //
          GestureDetector(
            onTap: _scrollToContainer2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(64, 60, 254, 0.8),
              ),
              height: 45,
              width: 115,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 35,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 25,
                        width: 25,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff6562FD),
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//
//
// req quote form for wheels
//
//
  Container requestAQuoteMethodWheels(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      // color: Colors.blue,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // request quote
          //
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Text(
              "Request a Quote",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF073358),
              ),
            ),
          ),

          // series name box
          //
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Wheel Code : $getTitle",
                  style: const TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                )),
          ),

          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Wheel Diameter");
            },
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
                        "Wheel Diameter : $wheelDiameter", // later change var
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
                        wheelDiameter = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: wheelDiameter != ""
                          ? const Icon(
                              Icons.close,
                              size: 20,
                              color: Color.fromARGB(74, 0, 0, 0),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // brake type
          //
          GestureDetector(
            onTap: () {
              _showBottomDrawer1(context, "Tread With");
            },
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
                          "Tread with : $wheelTreadWidth", // later change var
                          style: TextStyle(
                            color: Color(0xFF706C6C),
                          ),
                        )),
                  ),
                  //
                  // clear icon
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        wheelTreadWidth = "";
                      });
                    },
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      // color: Colors.yellow,
                      child: wheelTreadWidth != ""
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

          const SizedBox(
            height: 20,
          ),
          //
          // quantity
          //
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quantity",
                  style: TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                ),
                Container(
                  // color: Colors.grey,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  //
                  // stepper counter adder + -
                  //
                  child: Row(
                    children: [
                      //
                      // minus sign
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (stepper > 1) {
                              stepper--;
                              quantity = stepper.toString();
                              print(quantity);
                            }
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF403CFE),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // Ui box to show quantity
                      //
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                        child: Center(child: Text("$stepper")),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // add icon
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            stepper++;
                            quantity = stepper.toString();
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFEDEAFD),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //
          // button for scroll to next screen
          //
          const SizedBox(
            height: 50,
          ),
          //
          // Next Button for slide to next form
          //
          GestureDetector(
            onTap: _scrollToContainer2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(64, 60, 254, 0.8),
              ),
              height: 45,
              width: 115,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 35,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 25,
                        width: 25,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff6562FD),
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//
//
// req quote form for trolleys
//
//
  Container requestAQuoteMethodTrolleys(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      // color: Colors.blue,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // request quote
          //
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Text(
              "Request a Quote",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF073358),
              ),
            ),
          ),

          // series name box
          //
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Trolley Name : $getTitle",
                  style: const TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),

          //
          // quantity
          //
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quantity",
                  style: TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                ),
                Container(
                  // color: Colors.grey,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  //
                  // stepper counter adder + -
                  //
                  child: Row(
                    children: [
                      //
                      // minus sign
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (stepper > 1) {
                              stepper--;
                              quantity = stepper.toString();
                              print(quantity);
                            }
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF403CFE),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // Ui box to show quantity
                      //
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                        child: Center(child: Text("$stepper")),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // add icon
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            stepper++;
                            quantity = stepper.toString();
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFEDEAFD),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //
          // button for scroll to next screen
          //
          const SizedBox(
            height: 50,
          ),
          //
          // Next Button for slide to next form
          //
          GestureDetector(
            onTap: _scrollToContainer2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(64, 60, 254, 0.8),
              ),
              height: 45,
              width: 115,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 35,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 25,
                        width: 25,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff6562FD),
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
//
// req quote form for trolleys
//
//
  Container requestAQuoteMethodOtherProducts(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      // color: Colors.blue,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // request quote
          //
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Text(
              "Request a Quote",
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF073358),
              ),
            ),
          ),

          // series name box
          //
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Name : $getTitle",
                  style: const TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),

          //
          // quantity
          //
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(25, 37, 136, 0.15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quantity",
                  style: TextStyle(
                    color: Color(0xFF706C6C),
                  ),
                ),
                Container(
                  // color: Colors.grey,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  //
                  // stepper counter adder + -
                  //
                  child: Row(
                    children: [
                      //
                      // minus sign
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (stepper > 1) {
                              stepper--;
                              quantity = stepper.toString();
                              print(quantity);
                            }
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF403CFE),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // Ui box to show quantity
                      //
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                        child: Center(child: Text("$stepper")),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //
                      // add icon
                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            stepper++;
                            quantity = stepper.toString();
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFEDEAFD),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //
          // button for scroll to next screen
          //
          const SizedBox(
            height: 50,
          ),
          //
          // Next Button for slide to next form
          //
          GestureDetector(
            onTap: _scrollToContainer2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(64, 60, 254, 0.8),
              ),
              height: 45,
              width: 115,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 35,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 25,
                        width: 25,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff6562FD),
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
