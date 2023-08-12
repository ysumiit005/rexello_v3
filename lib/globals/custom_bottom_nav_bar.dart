import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/request_quote_screen/request_quote_screen.dart';
import 'device_size.dart';

class CustomBottonNavBar extends StatelessWidget {
  const CustomBottonNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    // ignore: unused_local_variable
    double figmascreensizeWidth = 390;
    double figmascreensizeHeight = 844;
    return Builder(builder: (context) {
      final double mobWidth = MediaQuery.of(context).size.width;
      return SizedBox(
        width: mobWidth,
        height: DeviceSize.height * (55 / figmascreensizeHeight),
        child: Row(
          children: [
            //
            // ask an expert
            //
            GestureDetector(
              onTap: () async {
                Uri phoneno = Uri.parse('tel:+02240917777');
                if (await launchUrl(phoneno)) {
                  //dialer opened
                } else {
                  //dailer is not opened
                }
              },
              child: Container(
                color: const Color(0xFF073358),
                width: mobWidth / 2,
                height: DeviceSize.height * (55 / figmascreensizeHeight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ask an Expert   ",
                      style: TextStyle(
                          fontSize: DeviceSize.height * (15 / figmascreensizeHeight),
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset(
                      'assets/svgs/ask_expert.svg',
                      color: Colors.white,
                      height: DeviceSize.height * (23 / figmascreensizeHeight),
                      width: DeviceSize.height * (23 / figmascreensizeHeight),
                    ),
                  ],
                ),
              ),
            ),
            //
            // request a quote
            //
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
                color: const Color.fromRGBO(255, 0, 0, 1),
                width: mobWidth / 2,
                height: DeviceSize.height * (55 / figmascreensizeHeight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send an Enquiry  ",
                      style: TextStyle(
                          fontSize: DeviceSize.height * (15 / figmascreensizeHeight),
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: DeviceSize.height * (23 / figmascreensizeHeight),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
