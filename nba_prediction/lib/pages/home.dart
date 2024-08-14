import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),

    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'NBA Predictor',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
    );
  }
}