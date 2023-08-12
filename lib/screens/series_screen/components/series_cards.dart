import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../globals/device_size.dart';
import '../../detail_screen/detail_screen.dart';

class SeriesCards extends StatelessWidget {
  const SeriesCards({
    super.key,
    required this.heroId,
    required this.image,
    required this.title,
    required this.weight,
    required this.description, required this.type,
  });

  final int heroId;
  final String image;
  final String title;
  final String weight;
  final String description;
  final String type;

  @override
  Widget build(BuildContext context) {
    print('inside series cards');
    print(heroId);
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/details', arguments: {
        //   'heroTagId': heroId,
        //   'title': title,
        //   'weight': weight,
        //   'image': image,
        //   'description': description,
        // });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              description: description,
              heroId: heroId,
              image: image,
              title: title,
              weight: weight,
              type: type,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: 0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Color.fromRGBO(7, 51, 88, 1)),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/weight_kg_icon.svg',
                    color: Colors.black,
                    height: DeviceSize.height * (16 / DeviceSize.figmascreensizeHeight),
                    width: DeviceSize.height * (16 / DeviceSize.figmascreensizeWidth),
                    // Other properties and customization options
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Text(
                      weight,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inter',
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SizedBox(
                // width: MediaQuery.of(context).size.width,
                height: 80,
                child: Hero(
                  tag: heroId,
                  child: Image.network(
                    image,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
