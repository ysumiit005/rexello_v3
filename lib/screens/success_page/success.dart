import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Success Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuccessPage(),
    );
  }
}



class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}


class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://icon-library.com/images/success-icon-png/success-icon-png-22.jpg', // Replace with the actual path of the GIF file
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Success!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text(
                'Back to Home!',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
