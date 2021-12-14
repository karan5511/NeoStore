import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Product_Details/Product_Details_State.dart';
import 'package:neo_store/Bloc/Product_Details/Product_Details_bloc.dart';
import 'package:neo_store/Bloc/Product_Details/Product_Details_event.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/add_to_cart.dart';
import 'package:neo_store/model/Product_Details_model.dart';
import 'package:neo_store/model/Product_List_model.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:neo_store/model/cart_list_model.dart';
import 'package:neo_store/model/my_cart_model.dart';
import 'package:neo_store/model/set_product_rating_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Home_Page.dart';
import 'package:http/http.dart' as http;

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage(
      {Key key,
      this.title,
      this.id,
      this.productDetail,
      this.user,
      this.cartList,
      this.products})
      : super(key: key);

  final String title;
  final int id;

  ProductDetail productDetail;
  RegisterResponseModel user;
  CartItems cartList;
  ProductListResponseModel products;
  AddToCartRepo addToCartRepo;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var rating = 5.0;

  List<Images> data;
  String image;
  int position = 0;
  String quant;

  TextEditingController quants = TextEditingController();

  @override
  void initState() {
    data = widget.productDetail.data.product_images.map((e) => e).toList();
    print('product');

    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocProvider<ProductDetailBloc>(
        create: (context) => ProductDetailBloc(
          addToCartRepo: context.read<AddToCartRepo>(),
        ),
        child: _bottom(),
      ),
      appBar: _appBar(),
      // drawer:,
      body: BlocProvider<ProductDetailBloc>(
        create: (context) => ProductDetailBloc(
          addToCartRepo: context.read<AddToCartRepo>(),
        ),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            _Tile(),
            _images(),
          ]),
        ),
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
          "${widget.productDetail.data.description}",
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
            "${widget.productDetail.data.name}",
            style: TextStyle(
                fontSize: 15.0, color: lblack, fontWeight: FontWeight.w600),
          ), //data[index].title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.0,
              ),
              Text("Category - Table",
                  style: TextStyle(
                      fontSize: 10.0,
                      color: lblack,
                      fontWeight: FontWeight.w100)),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.productDetail.data.producer}",
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
      title: Text('${widget.productDetail.data.name}',
          style: TextStyle(
              color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
      centerTitle: true,
    );
  }

  Widget _images() {
    List<Images> imageList = widget.productDetail.data.product_images;
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
                        '${widget.productDetail.data.cost}',
                        style: TextStyle(
                            color: myRed1,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.66),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.share,
                            color: grey1,
                            size: 23,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                  Image.network(image != null ? image : data[0].image),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: imageList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          position = index;
                                          centerImage(imageList[index].image);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: position == index
                                                  ? Colors.red
                                                  : Colors.black,
                                              width: 2),
                                        ),
                                        child: Image.network(
                                            imageList[index].image),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
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

  centerImage(String img) {
    setState(() {
      image = img;
    });
  }

  Widget _rating() {
    return SmoothStarRating(
      rating: rating,
      color: Colors.amber,
      borderColor: Colors.grey,
      isReadOnly: false,
      size: 12,
      filledIconData: Icons.star,
      defaultIconData: Icons.star,
      starCount: 5,
      onRated: (value) {
        print("rating value -> $value");
      },
    );
  }

  Widget _bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.3, horizontal: 3.0),
      child: Container(
        color: white,
        child: Row(
          children: [
            SizedBox(width: 3.0),
            _buyNow(),
            SizedBox(width: 6.0),
            _rateNow(),
            SizedBox(width: 3.0),
          ],
        ),
      ),
    );
  }

  Widget _CartDialog(BuildContext context) {
    return new AlertDialog(
      title: Text("${widget.productDetail.data.name}",
          style: TextStyle(
              color: black, fontWeight: FontWeight.w700, fontSize: 25.0)),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 33.33),
              child: Image.network(image != null ? image : data[0].image),
            ),
            Center(
                child: Text(
              "Enter Qty",
              style: TextStyle(
                  color: blackDark, fontSize: 20, fontWeight: FontWeight.w600),
            )),
            SizedBox(height: 22.0),
            Center(
              child: Container(
                height: 43,
                width: 112,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: quants,
                  cursorColor: white,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: blackDark),
                      ),
                      errorStyle: TextStyle(color: blackDark),
                      labelStyle: TextStyle(fontSize: 8.0)),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(height: 22.0),
            Center(
              child: Container(
                height: 47.33,
                width: 198.33,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: myRed1)),
                  onPressed: () async {
                    String value = quants.text;

                    print('${widget.user.data.accessToken}');
                    print('${widget.productDetail.data.id}');
                    print("$value");

                    Navigator.pop(context);
                  },
                  color: buttonRed,
                  child: Text("SUBMIT",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingDialog(BuildContext context) {
    var rating = 5.0;
    return new AlertDialog(
      title: Text("${widget.productDetail.data.name}",
          style: TextStyle(
              color: black, fontWeight: FontWeight.w700, fontSize: 25.0)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(image != null ? image : data[0].image),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              children: [
                Center(
                  child: Container(
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
                          setState(() {
                            this.rating = value;
                          });
                          print("rating value -> $value");
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: myRed1)),
              onPressed: () async {
                await addRating(
                    widget.productDetail.data.id.toString(), rating.toInt());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              color: buttonRed,
              child: Text("RATE NOW",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Future<Cart> addCartData(String accessToken, String quants, String id) async {
    var url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/addToCart');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'product_id': id.toString(),
      'quantity': quants,
    });
    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = cartFromJson(response.body);

      print(response.body);
//  print(jsonBody.data);

      return jsonBody;
    } else {
      final jsonBody = cartFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }

  Future<void> addRating(String productId, int rating) async {
    var url = Uri.parse(
        'http://staging.php-dev.in:8844/trainingapp/api/products/setRating');
    print(url);
    final response = await http.post(url, body: {
      'product_id': productId,
      'rating': rating.toString(),
    });
    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = setProductRatingFromJson(response.body);

      print(response.body);
//  print(jsonBody.data);

      return jsonBody;
    } else {
      final jsonBody = setProductRatingFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }

  Widget _buyNow() {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
      if (state.addToCart != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) => _CartDialog(context),
        );
      }
    }, builder: (context, state) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: myRed1,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: FlatButton(
            minWidth: 5.0,
            height: 8.0,
            textColor: Colors.white,
            onPressed: () {
              String qu = quants.text;
              print('${widget.user}');
              print("id: '${widget.productDetail.data.id}', quant: '${qu}' ");
              context.read<ProductDetailBloc>().add(buyNowButtonPressed(
                  id: '${widget.productDetail.data.id}',
                  quant: '1',
                  token: '${widget.user.data.accessToken}'));
              showDialog(
                context: context,
                builder: (BuildContext context) => _CartDialog(context),
              );
            },
            child: Text('BUY NOW', style: TextStyle(fontSize: 20.0)),
          ),
        ),
      );
    });
  }

  Widget _rateNow() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: FlatButton(
          minWidth: 5.0,
          height: 8.0,
          textColor: Colors.grey.shade800,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _ratingDialog(context),
            );
          },
          child: Text('RATE', style: TextStyle(fontSize: 20.0)),
        ),
      ),
    );
  }
}
