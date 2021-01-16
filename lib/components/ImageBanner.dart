import 'package:flutter/material.dart';

imageBanner({String imageURL, height: 200.0}) => Container(
      margin: EdgeInsets.only(bottom: 12.0),
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imageURL),
        ),
      ),
    );
