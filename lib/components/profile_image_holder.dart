import 'package:ess_ward/res/images.dart';
import 'package:flutter/material.dart' hide Colors;

class ProfileImageHolder extends StatelessWidget {
  final String image;
  const ProfileImageHolder({super.key, this.image = imagePlaceHolder});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Image.asset(image),
          );
  }
}