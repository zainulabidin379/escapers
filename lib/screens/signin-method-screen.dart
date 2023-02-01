import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens.dart';
import '../models/models.dart';
import '../shared/constants.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInMethod extends StatefulWidget {
  @override
  _SignInMethodState createState() => _SignInMethodState();
}

class _SignInMethodState extends State<SignInMethod> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg-splash.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 70.0, right: 70.0, top: 100.0, bottom: 70.0),
              child: Image.asset(
                'assets/images/LOGO.png',
                fit: BoxFit.contain,
              ),
            ),
            new Spacer(),
            new Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),),
                      child: Text(
                        'Sign in with Email',
                        style: kBodyText,
                      ),
                    ),
                  ),
                ))
              ],
            ),
            new Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
                  child: InkWell(
                    onTap: () async {
                      await _auth.signInWithGoogle();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xFFDB4437),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),),
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: kWhite,
                          size: 28,
                        )
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
                  child: InkWell(
                    onTap: () {
                      Get.snackbar(
                        'Message',
                        'Facebook Sign In is not implemented yet',
                        duration: Duration(seconds: 3),
                        backgroundColor: Color(0xFF3b5998),
                        colorText: kWhite,
                        borderRadius: 10,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Color(0xFF3b5998),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),),
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        color: kWhite,
                        size: 28,
                      )
                    ),
                  ),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: kBodyText,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Sign up",
                      style: kBodyText.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
