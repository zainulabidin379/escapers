import 'package:escapers_app/screens/explore-screen.dart';
import 'package:escapers_app/screens/profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../screens/screens.dart';

class OnBoardingList {
  final int id;
  final String title;
  final String text;

  OnBoardingList({this.id, this.title, this.text});

  static List<OnBoardingList> list = [
    OnBoardingList(
      id: 1,
      title: "Visit the best places of Pakistan",
      text:
          "We are providing the best solution to ease your traveling experience. Escapers is a complete guide to choose the best destination in the country and to make your journey more enjoyable.",
    ),
    OnBoardingList(
      id: 2,
      title: "Hunza Valley",
      text:
          "Hunza is a mountainous valley in the autonomous Gilgit-Baltistan region of Pakistan. Hunza is situated in the northern part of Gilgit-Baltistan, Pakistan, bordering with Khyber Pakhtunkhwa to the west and the Xinjiang region of China.",
    ),
    OnBoardingList(
      id: 3,
      title: "Skardu",
      text:
          "Skardu is a city located in Gilgit−Baltistan, Pakistan, and serves as the capital of the Skardu District. Skardu is situated at an elevation of nearly 2,500 metres in the Skardu Valley, at the confluence of the Indus and Shigar Rivers.",
    ),
    OnBoardingList(
      id: 4,
      title: "Islamabad",
      text:
          "The city is sheltered by the Margalla Hills, the foothills of the Himalayas and the home of rare species of leopard, deer, birds, and even porcupines. Several hiking paths end at Daman-e-Koh, a picnic spot with a splendid view of the entire city, including the massive modernist Faisal Mosque and even the Rawal Dam.",
    ),
    OnBoardingList(
      id: 5,
      title: "Kaghan Valley",
      text:
          "The Kaghan Valley is an alpine valley located in the Mansehra District of Khyber Pakhtunkhwa, Pakistan. The valley covers a distance of 155 kilometres across northern Pakistan, rising from its lowest elevation of 650 m to its highest point at the Babusar Pass around 4,170 m.",
    ),
  ];
}

class NavigationItem {
  IconData iconData;
  Widget page;

  NavigationItem(this.iconData, this.page);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(
      FontAwesomeIcons.globe,
      Explore(),
    ),
    NavigationItem(
      Icons.search,
      Search(),
    ),
    NavigationItem(
      FontAwesomeIcons.solidHeart,
      Favourites(),
    ),
    NavigationItem(
      Icons.history,
      MyBookings(),
    ),
    NavigationItem(
      Icons.person,
      Profile(),
    ),
  ];
}

class Place {
  String description;
  String country;
  double price;
  List<String> images;
  bool favorite;

  Place(this.description, this.price, this.country, this.images, this.favorite);
}

List<Place> getPlaceList() {
  return <Place>[
    Place(
        "Perfect weather + Mesmerizing views",
        5000,
        "Murree, Rawalpindi",
        [
          "assets/images/murree-1.jpg",
          "assets/images/murree-2.jpg",
          "assets/images/murree-3.jpg",
          "assets/images/murree-4.jpg",
        ],
        false),
    Place(
        "Faisal Mosque",
        2000,
        "Islamabad",
        [
          "assets/images/faisalmosque-0.jpg",
          "assets/images/faisalmosque-1.jpg",
          "assets/images/faisalmosque-2.jpg",
          "assets/images/faisalmosque-3.jpg",
        ],
        false),
    Place(
        "Badshahi Mosque",
        4000,
        "Lahore",
        [
          "assets/images/badshahimosque-0.jpg",
          "assets/images/badshahimosque-1.jpg",
          "assets/images/badshahimosque-2.jpg",
          "assets/images/badshahimosque-3.png",
        ],
        false),
    Place(
        "Mazaar-e-Quaid",
        10000,
        "Karachi",
        [
          "assets/images/mazarequaid-0.jpg",
          "assets/images/mazarequaid-1.jpg",
          "assets/images/mazarequaid-2.jpg",
        ],
        false),
    Place(
        "Daman-e-Koh",
        3000,
        "Islamabad",
        [
          "assets/images/damanekoh-0.jpg",
          "assets/images/damanekoh-1.jpg",
        ],
        false),
    Place(
        "Fairy Medows",
        15000,
        "Gilgit-Baltistan",
        [
          "assets/images/fairymedows-0.jpg",
          "assets/images/fairymedows-1.jpg",
          "assets/images/fairymedows-2.jpg",
        ],
        false),
  ];
}

class Cities {
  String city;
  String iconUrl;
  Function onTap;

  Cities(this.city, this.iconUrl, this.onTap);
}

List<Cities> getCitiesList() {
  return <Cities>[
    Cities(
      "Historical",
      "assets/icons/historical.png",
      () => Get.to(() => HistoricalDestinations()),
    ),
    Cities(
      "Adventure",
      "assets/icons/adventure.png",
      () => Get.to(() => AdventureDestinations()),
    ),
    Cities(
      "Luxury",
      "assets/icons/luxury.png",
      () => Get.to(() => LuxuryDestinations()),
    ),
    Cities(
      "Sports",
      "assets/icons/sport.png",
      () => Get.to(() => SportsDestinations()),
    ),
    Cities(
      "Attractive",
      "assets/icons/attractive.png",
      () => Get.to(() => AttractiveDestinations()),
    ),
    Cities(
      "Mysteries",
      "assets/icons/mysteries.png",
      () => Get.to(() => MysteriesDestinations()),
    ),
  ];
}

class Categories {
  String title;
  String imageUrl;
  Function ontap;

  Categories(this.title, this.imageUrl, this.ontap);
}

List<Categories> getCategoriesList() {
  return <Categories>[
    Categories(
      "Punjab",
      "assets/images/historical.jpg",
      () => Get.to(() => Punjab()),
    ),
    Categories(
      "Islamabad",
      "assets/images/cultural.jpg",
      () => Get.to(() => Islamabad()),
    ),
    Categories(
      "Sindh",
      "assets/images/religious.jpg",
      () => Get.to(() => Sindh()),
    ),
    Categories(
      "Khyber Pakhtun Khawa",
      "assets/images/fairymedows-0.jpg",
      () => Get.to(() => KPK()),
    ),
    Categories(
      "Balochistan",
      "assets/images/murree-2.jpg",
      () {},
    ),
  ];
}
