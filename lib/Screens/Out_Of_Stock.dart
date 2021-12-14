import 'package:flutter/material.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OutOfStockPage extends StatefulWidget {
  OutOfStockPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OutOfStockPageState createState() => _OutOfStockPageState();
}

class _OutOfStockPageState extends State<OutOfStockPage> {
  var rating = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13.33, vertical: 8.66),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: red)),
                    color: red,
                    height: 52,
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(color: gray, fontSize: 17.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: FlatButton(
                    color: gray,
                    height: 52,
                    child: Text(
                      "RATE",
                      style: TextStyle(color: gray, fontSize: 17.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: _appBar(),
      // drawer:,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _Tile(),
          _images(),
        ]),
      ),
    );
  }

  Widget _description() {
    return Container(
      height: 96.66,
      child: ListTile(
        title: Text(
          "Description",
          style: TextStyle(
              fontSize: 15.0, color: lblack, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
          style: TextStyle(
              fontSize: 15.0, color: lblack, fontWeight: FontWeight.w100),
        ),
      ),
    );
  }

  Widget _Tile() {
    return Container(
      child: Container(
        child: ListTile(
          title: Text(
            "6 Seater Dining Table for Family",
            style: TextStyle(
                fontSize: 15.0, color: lblack, fontWeight: FontWeight.w600),
          ), //data[index].title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.0,
              ),
              Text("Category - Tables ",
                  style: TextStyle(
                      fontSize: 10.0,
                      color: lblack,
                      fontWeight: FontWeight.w100)),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Future Furniture Center",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: lblack,
                        fontWeight: FontWeight.w100,
                      )),
                  _rating(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      backgroundColor: myRed1,
      elevation: 0.0,
      title: Text('6 Seater Dining Table',
          style: TextStyle(
              color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
      centerTitle: true,
    );
  }

  Widget _images() {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs. 27,390',
                        style: TextStyle(
                            color: myRed1,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.66),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Text(
                        "Out of Stock",
                        style: TextStyle(
                            color: myRed1,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.33),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: grey1,
                          size: 23,
                        ),
                        onPressed: () {},
                      ),

                      // Icon(Icons.share, color: lblack, size: 35),
                    ],
                  ),
                  // Image.asset('assets/product_images/table2.jfif'),
                  Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU',
                        height: 78,
                        width: 69,
                      ),
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU',
                        height: 78,
                        width: 69,
                      ),
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU',
                        height: 78,
                        width: 69,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                  _description(),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _rating() {
    return SmoothStarRating(
      rating: rating,
      color: Colors.amber,
      borderColor: Colors.grey,
      isReadOnly: false,
      size: 12,
      filledIconData: Icons.star,
      // halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star,
      starCount: 5,
      // allowHalfRating: true,

      onRated: (value) {
        print("rating value -> $value");
        // print("rating value dd -> ${value.truncate()}");
      },
    );
  }

  Widget _bottom() {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 3.0),
          Expanded(
            child: FlatButton(
              minWidth: 5.0,
              height: 8.0,
              textColor: Colors.white,
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text('Buy Now', style: TextStyle(fontSize: 20.0)),
            ),
          ),
          SizedBox(width: 2.0),
          Expanded(
            child: FlatButton(
              minWidth: 5.0,
              height: 8.0,
              textColor: Colors.grey.shade800,
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text('Rate', style: TextStyle(fontSize: 20.0)),
            ),
          ),
          SizedBox(width: 3.0),
        ],
      ),
    );
  }
}
