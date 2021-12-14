import 'package:flutter/material.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Home_Page.dart';

class RatingPopUpPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popup Menu Example - FlutterCorner'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            'Show Pop-up',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.black,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  var rating = 5.0;
  return new AlertDialog(
    title: const Text('6 Seater Dining Table'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU'),
        Center(
          child: Row(
            children: [
              Container(
                height: 44.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothStarRating(
                    rating: rating,
                    color: Colors.amber,
                    borderColor: Colors.grey,
                    isReadOnly: false,
                    size: 44,
                    filledIconData: Icons.star,
                    defaultIconData: Icons.star,
                    starCount: 5,
                    allowHalfRating: true,
                    onRated: (value) {
                      print("rating value -> $value");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: myRed1)),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          color: buttonRed,
          child: Text("RATE NOW",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    ),
    actions: <Widget>[],
  );
}
