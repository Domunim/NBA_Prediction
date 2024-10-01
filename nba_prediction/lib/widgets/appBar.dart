  import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      // Remove `leading` to avoid any element on the left side
      title: Image.asset(
        'assets/images/NBA_predictor_logo.png',
        fit: BoxFit.contain,
        height: 100,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            // Dark mode TODO
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/dark_light_mode_icon.svg',
              height: 30,
              width: 30,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }