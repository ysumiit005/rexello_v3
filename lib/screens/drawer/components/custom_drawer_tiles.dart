import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawerTiles extends StatelessWidget {
  const CustomDrawerTiles({
    super.key,
    required this.getIcon,
    required this.getTitle,
  });

  final String getIcon;
  final String getTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // icon
          Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.symmetric(horizontal: 11),
            child: SvgPicture.asset(
              getIcon,
              height: 15,
              color: const Color(0xFF645656),
            ),
          ),

          // test
          Expanded(
            child: Container(
              height: 28,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getTitle,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
