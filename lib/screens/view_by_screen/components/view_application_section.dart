import 'package:flutter/material.dart';
import '../../../globals/device_size.dart';
import 'application_card_section.dart';

class ViewApplicationSection extends StatelessWidget {
  const ViewApplicationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DeviceSize.setScreenSize(context);
    double figmascreensizeWidth = 390;
    double figmascreensizeHeight = 844;
    return Container(
      //
      //
      // added background image to application section container (fixed on screen)
      //
      //
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.fill,
        ),
        // color: Color.fromRGBO(255, 255, 255, 1.0),
      ),

      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            //
            //
            // product cards
            //
            //
            ApplicationsCardSection(figmascreensizeWidth: figmascreensizeWidth, figmascreensizeHeight: figmascreensizeHeight),
            //
            // some manual space
            SizedBox(
              height: DeviceSize.height * (15 / figmascreensizeHeight),
            ),
          ],
        ),
      ),
    );
  }
}
