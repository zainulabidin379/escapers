import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escapers_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';

class Islamabad extends StatefulWidget {
  @override
  _IslamabadState createState() => _IslamabadState();
}

class _IslamabadState extends State<Islamabad> {
  Future getPlaces() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('islamabad').get();

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
            "Islamabad",
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
              FutureBuilder<dynamic>(
                  future: getPlaces(),
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
                            placeCard(
                              size,
                              snapshot.data[i]['avatar'],
                              snapshot.data[i]['Place'],
                              snapshot.data[i]['Description'],
                              snapshot.data[i]['Price'],
                            ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ));
  }

  Widget placeCard(
    Size size,
    String image,
    String place,
    String description,
    String price,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Center(
          child: Column(
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  border: Border.all(color: kPrimaryColor, width: 2),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                  color: kWhite,
                ),
              ),
              Container(
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.zero,
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
                      Text(
                        description,
                        style: kBodyText.copyWith(
                          fontSize: 16,
                          height: 1.2,
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => Booking(
                        place: place,
                        price: double.parse(price),
                      ));
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
                      'Book Now',
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
