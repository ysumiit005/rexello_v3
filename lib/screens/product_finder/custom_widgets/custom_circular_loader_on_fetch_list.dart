import 'package:flutter/material.dart';

class CustomCircularLoaderOnFetchList extends StatelessWidget {
  const CustomCircularLoaderOnFetchList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        // color: Colors.black12,
        child: Align(
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 1,
            child: Container(
              height: 50,
              width: 50,
              // color: Colors.amber,
              child: const CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
