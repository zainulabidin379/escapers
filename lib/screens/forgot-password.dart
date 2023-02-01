import 'package:the_validator/the_validator.dart';
import 'package:get/get.dart';
import '../shared/constants.dart';
import '../shared/rounded-button.dart';
import 'package:flutter/material.dart';
import '../shared/background-image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/bg-login.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Forgot Password',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Text(
                    'Enter your Email we will send instructions to reset your password',
                    style: kBodyText,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //Email
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextFormField(
                            controller: emailController,
                            style: kBodyText,
                            cursorColor: kPrimaryColor,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Email',
                              hintStyle: kBodyText.copyWith(fontSize: 20, color: kGrey),
                              prefixIcon: Icon(
                                FontAwesomeIcons.envelope,
                                color: kWhite,
                                size: 20,
                              ),
                              errorStyle: TextStyle(
                                fontSize: 16.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: kPrimaryColor, width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: FieldValidator.email(),
                          ),
                        ),

                        SizedBox(
                          height: 25,
                        ),

                        Center(
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                print("successful");
                                print(emailController.text);
                                Get.snackbar(
                                  'Message',
                                  'This option is not yet implemented',
                                  duration: Duration(seconds: 3),
                                  backgroundColor: kPrimaryColor,
                                  colorText: kWhite,
                                  borderRadius: 10,
                                );
                                return;
                              } else {
                                print("UnSuccessful");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 50,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Text(
                                  'Send',
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
