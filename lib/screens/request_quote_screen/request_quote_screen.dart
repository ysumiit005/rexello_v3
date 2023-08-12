import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:rexello_tests_only_home/globals/device_size.dart';
import '../../globals/custom_app_bar.dart';
import '../../models/req_quote.dart';
import '../drawer/custom_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RequestQuoteScreen(),
    );
  }
}

class RequestQuoteScreen extends StatefulWidget {
  const RequestQuoteScreen({super.key});

  State<RequestQuoteScreen> createState() => RequestQuoteScreenState();
}

class RequestQuoteScreenState extends State<RequestQuoteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//dispose all
  @override
  void dispose() {
    userName.dispose();
    userPhone.dispose();
    userEmail.dispose();
    userAddress.dispose();
    userMessage.dispose();
    userWebsite.dispose();

    // Reset variables
    _isLoading = false;
    _isButtonDisabled = false;
    isUserDataSaved = false;
    productType = null;
    applicationType = null;

    super.dispose();
  }

  //var
  //user detail
  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userMessage = TextEditingController();
  TextEditingController userWebsite = TextEditingController();

  // functions for circular loader in submit button
  //
  bool _isLoading = false;
  bool _isButtonDisabled = false;

  void _handleSubmit() {
    setState(() {
      _isLoading = true;
    });

    // Simulating an asynchronous operation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
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

    //
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
            height: 20,
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
          "userProductType=${productType}&"
          "userApplicationType=${applicationType}&"
          "userName=${userName.text}&"
          "userPhone=${userPhone.text}&"
          "userEmail=${userEmail.text}&"
          "userAddress=${userAddress.text}&"
          "userMessage=${userMessage.text}&"
          "userWebsite=${userWebsite.text}";

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
        await Future.delayed(Duration(seconds: 3)); //success will be visible for thsi duration
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
  // variable to save user input using bottom modal
  // var
  String? productType;
  String? applicationType;

  //list of data shown in modal
  List<String> productTypeList = ["Castors", "Wheels", "Trolleys", "Others"];
  List<String> applicationTypeList = [
    "Hospitals",
    "Manufacturers",
    "Shopping Malls",
    "Air Ports",
    "Fire Departments",
    "Harbours",
    "Bridge Road Construction",
    "Waste Water Treatment Plant",
    "Recycling",
  ];

  //
  // textform field only take numbers
  //
  final TextInputFormatter _numberFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              children: [
                //
                // custom appbar
                //
                CustomAppBar(
                  scaffoldKey: _scaffoldKey,
                  title: "",
                ),
                //
                // request a quote
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // request quote

                        const SizedBox(
                          height: 25,
                        ),
                        const Center(
                          child: Text(
                            "Send an Enquiry",
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
                                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
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
                              decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Name *",
                                  hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
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
                              controller: userPhone,
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
                                  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

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
                                  hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
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
                        // user/company website url
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
                            child: TextFormField(
                              controller: userWebsite,
                              decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Company Website",
                                  hintStyle: TextStyle(color: Color(0xFF706C6C), fontSize: 15)),
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
                                // //
                                // // check message
                                // if (userMessage.text.isEmpty || userMessage.text == "") {
                                //   setState(() {
                                //     isUserMessageValid = false;
                                //   });
                                // } else {
                                //   setState(() {
                                //     isUserMessageValid = true;
                                //   });
                                // }
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

                        const SizedBox(
                          height: 20,
                        ),
                        // product type
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
                                builder: (BuildContext context) {
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
                                        const Text(
                                          "Product Type",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: productTypeList.length,
                                            itemBuilder: (context, index) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      productType = productTypeList[index];
                                                      //closes modal automatic after user selects option in modal
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  splashColor: Colors.amber,
                                                  child: ListTile(
                                                    title: Text(productTypeList[index]),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 45,
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
                                        productType ?? "Product Type",
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
                                        productType = null;
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: double.infinity,
                                      // color: Colors.yellow,
                                      child: productType != null
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

                        const SizedBox(
                          height: 20,
                        ),
                        // application type
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
                                builder: (BuildContext context) {
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
                                        const Text(
                                          "Application Type",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: applicationTypeList.length,
                                            itemBuilder: (context, index) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      applicationType = applicationTypeList[index];
                                                      //closes modal automatic after user selects option in modal
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  splashColor: Colors.amber,
                                                  child: ListTile(
                                                    title: Text(applicationTypeList[index]),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 45,
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
                                        applicationType ?? "Application Type",
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
                                        applicationType = null;
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: double.infinity,
                                      // color: Colors.yellow,
                                      child: applicationType != null
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

                        //
                        // Submit Button
                        //
                        const SizedBox(
                          height: 30,
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
                        ),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          endDrawer: const CustomDrawer()),
    );
  }
}
