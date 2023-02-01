import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escapers_app/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:the_validator/the_validator.dart';
import '../shared/shared.dart';

class Booking extends StatefulWidget {
  final String place;
  final double price;

  const Booking({Key key, this.place, this.price}) : super(key: key);
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _checkInController = new TextEditingController();
  TextEditingController _checkOutController = new TextEditingController();

  Future getPlaces() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('adventures').get();

    return qn.docs;
  }

  DateTime _checkInDate;
  String checkIn;
  DateTime _checkOutDate;
  String checkOut;
  double totalAmount = 0;

  calculateTotalAmount() {
    var totalDays = 1;
    var checkInDays = _checkInDate.day;
    for (int i = 1; i <= 30; i++) {
      if (checkInDays + i == _checkOutDate.day) {
        break;
      }
      totalDays++;
    }

    setState(() {
      totalAmount = totalDays * widget.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kBlack,
            ),
          ),
          title: Text(
            "Booking",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    widget.place,
                    style: kBodyText.copyWith(
                        fontSize: 25,
                        color: kBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: TextFormField(
                            controller: _checkInController,
                              enabled: false,
                              cursorColor: kBlack,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 26),
                                labelText: 'Check-In Date',
                                labelStyle: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: checkIn,
                                errorStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: kBlack,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: kBlack,
                                    width: 1.5,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: kBlack,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return 'Please choose Check-in date';
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 65.0, top: 20),
                          child: InkWell(
                            onTap: () {
                              _selectDateCheckIn(context);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(FontAwesomeIcons.calendarAlt,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: TextFormField(
                            controller: _checkOutController,
                              enabled: false,
                              cursorColor: kBlack,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 26),
                                labelText: 'Check-Out Date',
                                labelStyle: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: checkOut,
                                errorStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: kBlack,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: kBlack,
                                    width: 1.5,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                    color: kBlack,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return 'Please choose Check-out date';
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 65.0, top: 20),
                          child: InkWell(
                            onTap: () {
                              _selectDateCheckOut(context);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(FontAwesomeIcons.calendarAlt,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Amount:',
                        style: kBodyText.copyWith(
                            fontSize: 25,
                            color: kBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '  Rs. ${totalAmount.truncate()}',
                        style: kBodyText.copyWith(
                            fontSize: 25,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Center(
                        child: SpinKitCircle(
                          color: kPrimaryColor,
                          size: 50.0,
                        ),
                      ),
                    );

                    String email = FirebaseAuth.instance.currentUser.email;
                    FirebaseFirestore.instance
                        .collection('pending_bookings')
                        .doc()
                        .set({
                      "checkin": checkIn,
                      "checkout": checkOut,
                      "place": widget.place,
                      "price": totalAmount,
                      "user_email": email,
                    }).then((_) async {
                      Get.offAll(() => Home());
                      Get.snackbar(
                        '',
                        "Your booking is sent to our hosts.",
                        titleText: Text('Booking Sent',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        duration: Duration(seconds: 4),
                        backgroundColor: kPrimaryColor,
                        colorText: kWhite,
                        borderRadius: 10,
                      );
                    }).catchError((onError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(onError)));
                    });
                  }
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Book Tour Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<Null> _selectDateCheckIn(BuildContext context) async {
    var date = new DateTime.now();
    final DateTime _setDate = await showDatePicker(
        context: context,
        initialDate: _checkInDate == null ? DateTime.now() : _checkInDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(date.year, date.month + 2, date.day),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_setDate != null) {
      setState(() {
        _checkInDate = _setDate;
        checkIn =
            "${_checkInDate.day} - ${_checkInDate.month} - ${_checkInDate.year}";
        _checkInController.text = checkIn;
      });
    }
  }

  Future<Null> _selectDateCheckOut(BuildContext context) async {
    var date = new DateTime.now();
    final DateTime _setDate = await showDatePicker(
        context: context,
        initialDate: _checkOutDate == null ? _checkInDate : _checkOutDate,
        firstDate: _checkInDate,
        lastDate: DateTime(
            _checkInDate.year, _checkInDate.month + 1, _checkInDate.day),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_setDate != null) {
      setState(() {
        _checkOutDate = _setDate;
        checkOut =
            "${_checkOutDate.day} - ${_checkOutDate.month} - ${_checkOutDate.year}";
        _checkOutController.text = checkOut;
      });
      calculateTotalAmount();
    }
  }
}
