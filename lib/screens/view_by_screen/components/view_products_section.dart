import 'package:flutter/material.dart';
import '../../../globals/device_size.dart';
import 'product_card_section.dart';
import 'special_castors_section.dart';

class ViewProductsSection extends StatelessWidget {
  const ViewProductsSection({
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
      // added background image to products section container (fixed on screen)
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
            SizedBox(
              height: 16,
            ),
            //
            //
            // product cards
            //
            //
            ProductsCardSection(figmascreensizeWidth: figmascreensizeWidth, figmascreensizeHeight: figmascreensizeHeight),
            //
            // some manual space
            SizedBox(
              height: DeviceSize.height * (15 / figmascreensizeHeight),
            ),
            //
            //
            // banners special castors
            //
            //
            SpecialCastorsSection(figmascreensizeHeight: figmascreensizeHeight, figmascreensizeWidth: figmascreensizeWidth),
          ],
        ),
      ),
    );
  }
}
