import 'package:escapers_app/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/detail.dart';
import '../shared/constants.dart';
import '../models/data.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Place> places = getPlaceList();
  List<Cities> cities = getCitiesList();
  List<Categories> categories = getCategoriesList();

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
          "Explore",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 4,
            ),
            child: Text(
              "Featured Destinations",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 16,
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildPlaces(),
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 4,
            ),
            child: Text(
              "Destinations Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: buildDestinations(),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 4,
            ),
            child: Text(
              "Destinations in",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Container(
            height: size.height * 0.13,
            child: PageView(
              physics: BouncingScrollPhysics(),
              children: buildCategories(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPlaces() {
    List<Widget> list = [];
    for (var place in places) {
      list.add(buildPlace(place));
    }
    return list;
  }

  Widget buildPlace(Place place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(place: place)),
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Hero(
          tag: place.images[0],
          child: Container(
            width: 230,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(place.images[0]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      place.favorite = !place.favorite;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: 12,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        place.favorite ? Icons.favorite : Icons.favorite_border,
                        color: kPrimaryColor,
                        size: 36,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    bottom: 12,
                    right: 12,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          place.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              place.country,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildDestinations() {
    List<Widget> list = [];
    for (var cities in cities) {
      list.add(buildDestination(cities));
    }
    return list;
  }

  Widget buildDestination(Cities cities) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: cities.onTap,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          width: size.width * 0.3,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  cities.iconUrl,
                  height: 45,
                  fit: BoxFit.fitHeight,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  cities.city,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildCategories() {
    List<Widget> list = [];
    for (var categories in categories) {
      list.add(buildFeatured(categories));
    }
    return list;
  }

  Widget buildFeatured(Categories categories) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: GestureDetector(
        onTap: categories.ontap,
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Container(
            width: size.width * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(categories.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    categories.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
