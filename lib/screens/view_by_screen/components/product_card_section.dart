import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../../globals/device_size.dart';
import '../../../models/product_model.dart';
import '../../series_screen/series_screen.dart';
// import '../model/product_model.dart';

class ProductsCardSection extends StatefulWidget {
  const ProductsCardSection({
    super.key,
    required this.figmascreensizeWidth,
    required this.figmascreensizeHeight,
  });

  final double figmascreensizeWidth;
  final double figmascreensizeHeight;

  @override
  State<ProductsCardSection> createState() => _ProductsCardSectionState();
}

class _ProductsCardSectionState extends State<ProductsCardSection> {
  // String getProductsUrl =
  //     'https://360softwares.in/assignments/sniper/rexello_mobile/rexello_get_seriesdata_api/lightduty_series.php';
  // //'https://360softwares.in/assignments/sniper/rexello_mobile/response_seriesdata_json.php';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products_list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          //product card
          margin: EdgeInsets.only(
            left: DeviceSize.width * (26 / widget.figmascreensizeWidth),
            right: DeviceSize.width * (31 / widget.figmascreensizeWidth),
            bottom: DeviceSize.width * (27 / widget.figmascreensizeHeight),
          ),
          height: DeviceSize.height * (74 / widget.figmascreensizeHeight),
          width: DeviceSize.width * (333 / widget.figmascreensizeWidth),
          // color: Colors.amber,
          //
          child: Row(
            children: [
              //
              //image
              //
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height:
                      DeviceSize.height * (74 / widget.figmascreensizeHeight),
                  width:
                      DeviceSize.height * (74 / widget.figmascreensizeHeight),
                  decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(64, 60, 254, 1),
                              Color.fromRGBO(255, 0, 0, 1),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight),
                        width: 2.5,
                      ),
                      color: const Color.fromRGBO(217, 217, 217, 1.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    products_list[index].image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //
              // space between image and button
              //
              SizedBox(
                width: DeviceSize.width * (30 / widget.figmascreensizeWidth),
              ),
              //
              // button with titles (light duty)
              //
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeriesScreen(
                            getUrl: products_list[index].apiUrl,
                            type: products_list[index].type,
                            title: "",
                            
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: DeviceSize.height *
                          (74 / widget.figmascreensizeHeight),
                      width: DeviceSize.width *
                          (231 / widget.figmascreensizeWidth),
                      decoration: const BoxDecoration(
                        color: Color(0xFF073358),
                      ),
                      child: Column(
                        children: [
                          //
                          // product title inside button
                          //
                          Container(
                            color: const Color(0xFF073358),
                            height: DeviceSize.height *
                                ((74 * 0.5) / widget.figmascreensizeHeight),
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                products_list[index].title,
                                style: TextStyle(
                                  fontSize: DeviceSize.height *
                                      (18 / widget.figmascreensizeHeight),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          //
                          // weights and diameter with icon
                          //
                          Container(
                            color: const Color(0xFF073358),
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                              top: DeviceSize.height *
                                  (5 / widget.figmascreensizeHeight),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/weight_kg_icon.svg',
                                      color: Colors.white,
                                      height: DeviceSize.height *
                                          (16 / widget.figmascreensizeHeight),
                                      width: DeviceSize.height *
                                          (16 / widget.figmascreensizeWidth),
                                      // Other properties and customization options
                                    ),
                                    Text(
                                      '  ${products_list[index].weightNDiameter} ',
                                      style: TextStyle(
                                          fontSize: DeviceSize.height *
                                              (10 /
                                                  widget.figmascreensizeHeight),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white),
                                    ),
                                    SvgPicture.asset(
                                      'assets/svgs/diameter-outline.svg',
                                      color: Colors.white,
                                      height: DeviceSize.height *
                                          (16 / widget.figmascreensizeHeight),
                                      width: DeviceSize.height *
                                          (16 / widget.figmascreensizeWidth),
                                      // Other properties and customization options
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
