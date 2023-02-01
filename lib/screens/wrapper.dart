import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/screens.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<TheUser>(context);

    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot != null &&
              snapshot.hasData &&
              snapshot.data != ConnectivityResult.none) {
            if (user == null) {
              return SignInMethod();
            } else {
              return Home();
            }
          } else {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        width: size.width * 0.3,
                        child: Image.asset('assets/icons/internet.png')),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Center(
                      child: Text(
                    'Looks like you are Offline!',
                    style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height: size.height * 0.01),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Please check your internet connection and try again. ",
                      style: TextStyle(fontSize: size.width * 0.04),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ],
              ),
            );
          }
        });
  }
}