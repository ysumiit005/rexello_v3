// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
// import 'package:rexello_tests_only_home/screens/application_product_options/applications_product_options.dart';
// import 'package:rexello_tests_only_home/screens/view_by_screen/model/application_model.dart';
import '../../../globals/device_size.dart';
import '../../../models/application_model.dart';
import '../../application_product_options/applications_product_options.dart';
import '../../series_screen/series_screen.dart';

class ApplicationsCardSection extends StatelessWidget {
  const ApplicationsCardSection({
    super.key,
    required this.figmascreensizeWidth,
    required this.figmascreensizeHeight,
  });

  final double figmascreensizeWidth;
  final double figmascreensizeHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: applications_list.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          //
          // application card outer layout
          //
          margin: EdgeInsets.only(
            left: DeviceSize.width * (26 / figmascreensizeWidth),
            right: DeviceSize.width * (31 / figmascreensizeWidth),
            bottom: DeviceSize.width * (27 / figmascreensizeHeight),
          ),
          height: DeviceSize.height * (74 / figmascreensizeHeight),
          width: DeviceSize.width * (333 / figmascreensizeWidth),
          // color: Colors.amber,

          child: Row(
            children: [
              //
              //image
              //
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height: DeviceSize.height * (74 / figmascreensizeHeight),
                  width: DeviceSize.height * (74 / figmascreensizeHeight),
                  decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(64, 60, 254, 1),
                          Color.fromRGBO(255, 0, 0, 1),
                        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                        width: 2.5,
                      ),
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    applications_list[index].image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //
              // space between image and button
              //
              SizedBox(
                width: DeviceSize.width * (30 / figmascreensizeWidth),
              ),
              //
              // button with titles (applications))
              //
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplicationsProductOptionsScreen(
                            xyz: applications_list[index],
                          ),
                        ),
                      );
                      //       Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //   builder: (context) => SeriesScreen(
                      //     getUrl: applications_list[index].apiUrl!,
                      //     type: "castors",
                      //     title: applications_list[index].title,
                      //   ),
                      // ),
                      //      );
                      // MaterialPageRoute(
                      //   builder: (context) => ApplicationWebViewScreen(
                      //     rexUrl: applications_list[index].webUrl,
                      //     title: applications_list[index].title,
                      //   ),
                      // ),
                    },
                    child: Container(
                      height: DeviceSize.height * (74 / figmascreensizeHeight),
                      width: DeviceSize.width * (231 / figmascreensizeWidth),
                      decoration: const BoxDecoration(
                        color: Color(0xFF073358),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        color: const Color(0xFF073358),
                        height: DeviceSize.height * ((74 * 0.5) / figmascreensizeHeight),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            applications_list[index].title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: DeviceSize.height * (18 / figmascreensizeHeight),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
