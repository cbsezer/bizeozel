import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

// ignore: must_be_immutable
class ActivityImage extends StatelessWidget {
  String imgUrl;

  ActivityImage(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: context.height,
          width: context.width,
          child: Image.network(imgUrl),
        ),
      ),
    );
  }
}
