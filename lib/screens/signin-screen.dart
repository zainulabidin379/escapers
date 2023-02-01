import 'package:flutter/material.dart';
import 'screens.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_validator/the_validator.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword;
  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void initState() {
    _obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/bg-login.jpg',
        ),
        loading
            ? Loading()
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: size.width * 0.25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 70.0, right: 70.0, bottom: 70.0),
                        child: Image.asset(
                          'assets/images/LOGO.png',
                          fit: BoxFit.contain,
                        ),
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
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'Email',
                                    hintStyle: kBodyText.copyWith(
                                        fontSize: 20, color: kGrey),
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.envelope,
                                      color: kWhite,
                                      size: 20,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
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

                              //Password
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                child: TextFormField(
                                  controller: passwordController,
                                  style: kBodyText,
                                  obscureText: _obscurePassword,
                                  cursorColor: kPrimaryColor,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'Password',
                                    hintStyle: kBodyText.copyWith(
                                        fontSize: 20, color: kGrey),
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.lock,
                                      color: kWhite,
                                      size: 20,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
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
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: kWhite,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toggle the state of passwordVisible variable
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: FieldValidator.password(
                                      errorMessage:
                                          'Password must be of at least 6 characters',
                                      minLength: 6),
                                ),
                              ),

                              //Button
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: kBodyText,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });

                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                emailController.text,
                                                passwordController.text);

                                        if (result != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                          );
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });

                                          Get.snackbar(
                                            'Error',
                                            'Email/Password is not valid',
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            colorText: kWhite,
                                            borderRadius: 10,
                                          );
                                        }
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
                                        'Sign In',
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()),
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
                                        style: kBodyText.copyWith(
                                            color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
