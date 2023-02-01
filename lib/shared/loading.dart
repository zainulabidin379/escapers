import 'package:escapers_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitCircle(
          color: kPrimaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}