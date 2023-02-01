import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../shared/constants.dart';
import 'screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HostScreen extends StatefulWidget {
  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  Future getBookings() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('pending_bookings').get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Host Catalogue",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
            child: Container(
              width: 50,
              child: Icon(
                FontAwesomeIcons.solidBell,
                color: kBlack,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        FutureBuilder<dynamic>(
            future: getBookings(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: size.height * 0.18,
                  width: size.width,
                  child: Center(
                    child: SpinKitCircle(
                      color: kPrimaryColor,
                      size: 50.0,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    for (var i = 0; i < snapshot.data.length; i++)
                      bookingsCard(
                        size,
                        snapshot.data[i]['checkin'],
                        snapshot.data[i]['checkout'],
                        snapshot.data[i]['place'],
                        snapshot.data[i]['price'].toInt(),
                        snapshot.data[i]['user_email'],
                      ),
                  ],
                );
              }
            }),
      ])),
    );
  }

  Widget bookingsCard(
    Size size,
    String checkIn,
    String checkOut,
    String place,
    int price,
    String userEmail,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Center(
          child: Column(
            children: [
              Container(
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    border: Border.all(color: kPrimaryColor, width: 2)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place,
                        style: kBodyText.copyWith(
                            fontSize: 25,
                            color: kBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: Rs. $price',
                        textAlign: TextAlign.start,
                        style: kBodyText.copyWith(
                            fontSize: 22,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'Check In: ',
                            style: kBodyText.copyWith(
                              fontSize: 16,
                              height: 1.2,
                              color: kBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' $checkIn',
                            style: kBodyText.copyWith(
                              fontSize: 16,
                              height: 1.2,
                              color: kBlack,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Check Out: ',
                            style: kBodyText.copyWith(
                              fontSize: 16,
                              height: 1.2,
                              color: kBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' $checkOut',
                            style: kBodyText.copyWith(
                              fontSize: 16,
                              height: 1.2,
                              color: kBlack,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'User Email: ',
                            style: kBodyText.copyWith(
                              fontSize: 18,
                              height: 1.2,
                              color: kBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' $userEmail',
                            style: kBodyText.copyWith(
                              fontSize: 20,
                              height: 1.2,
                              color: kBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Center(
                      child: SpinKitCircle(
                        color: kPrimaryColor,
                        size: 50.0,
                      ),
                    ),
                  );
                  FirebaseFirestore.instance
                      .collection('confirmed_bookings')
                      .doc()
                      .set({
                    "checkin": checkIn,
                    "checkout": checkOut,
                    "location_link": place,
                    "price": price,
                    "Your_email": userEmail,
                    "Host_email": userEmail,
                  }).then((_) async {
                    Navigator.pop(context);
                    setState(() {});
                    Get.snackbar(
                      '',
                      "Booking is comfirmed.",
                      titleText: Text('Booking Confirmed',
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
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.zero,
                      topLeft: Radius.zero,
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Accept Booking',
                      style: kBodyText.copyWith(
                          fontSize: 25,
                          color: kWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
