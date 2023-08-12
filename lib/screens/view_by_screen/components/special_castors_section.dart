import 'package:flutter/material.dart';
import '../../../globals/device_size.dart';
import '../../../models/special_castors_model.dart';
import '../../series_screen/series_screen.dart';
// import '../model/special_castors_model.dart';

class SpecialCastorsSection extends StatefulWidget {
  const SpecialCastorsSection({
    super.key,
    required this.figmascreensizeHeight,
    required this.figmascreensizeWidth,
  });

  final double figmascreensizeHeight;
  final double figmascreensizeWidth;

  @override
  State<SpecialCastorsSection> createState() => _SpecialCastorsSectionState();
}

class _SpecialCastorsSectionState extends State<SpecialCastorsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceSize.width,
      padding: EdgeInsets.only(
        top: DeviceSize.height * (37 / widget.figmascreensizeHeight),
        left: DeviceSize.width * (22 / widget.figmascreensizeWidth),
        right: DeviceSize.width * (22 / widget.figmascreensizeWidth),
      ),
      color: Colors.black,
      child: Column(children: [
        //
        // title 'special castors' with red bar below
        //
        Container(
          padding: EdgeInsets.only(
            bottom: DeviceSize.height * (37 / widget.figmascreensizeHeight),
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Special Castors",
                  style: TextStyle(color: Colors.white, fontSize: DeviceSize.width * (69 / widget.figmascreensizeHeight)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      left: DeviceSize.width * (80 / widget.figmascreensizeWidth), top: DeviceSize.height * (8 / widget.figmascreensizeHeight)),
                  color: Colors.red,
                  height: DeviceSize.height * (3 / widget.figmascreensizeHeight),
                  width: DeviceSize.width * (149 / widget.figmascreensizeWidth),
                ),
              )
            ],
          ),
        ),
        //
        //
        // banners ui
        //
        // 1st
        SizedBox(
          height: 450,
          child: GridView.builder(
              padding: const EdgeInsets.only(top: 0, bottom: 10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 0.7,
                crossAxisSpacing: 30,
                mainAxisSpacing: 0,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: userList.length,
              itemBuilder: (BuildContext ctx, index) {
                User user = userList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesScreen(
                          getUrl: sp_castor_list[index].apiUrl,
                          type: sp_castor_list[index].type,
                          title: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            sp_castor_list[index].image,
                            fit: BoxFit.fill,
                            height: 100,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: DeviceSize.width * (40 / DeviceSize.figmascreensizeWidth),
                          child: Center(
                            child: Text(
                              sp_castor_list[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        //
        //2
      ]),
    );
  }
}

//
//
// model
//
//
class User {
  final String name;
  final double weight;
  final String image;
  final String description;

  User({required this.name, required this.weight, required this.image, required this.description});
}

final List<User> userList = [
  User(
    name: "User 1",
    weight: 70.0,
    image: "image1.jpg",
    description: "User 1 description",
  ),
  User(
    name: "User 2",
    weight: 65.0,
    image: "image2.jpg",
    description: "User 2 description",
  ),
  User(
    name: "User 2",
    weight: 65.0,
    image: "image2.jpg",
    description: "User 2 description",
  ),
  User(
    name: "User 2",
    weight: 65.0,
    image: "image2.jpg",
    description: "User 2 description",
  ),
  // Add more users as needed
];
