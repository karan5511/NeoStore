import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/model/Product_Details_model.dart';
import 'package:neo_store/model/Product_List_model.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;



import 'Product_Details.dart';



class ProductListPage extends StatefulWidget {

  ProductListPage({Key key, this.title,this.products,this.user}) : super(key: key);
  RegisterResponseModel user;
  ProductListResponseModel products;



  final String title;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  var rating = 5.0;

List<Data> data;
    bool isLoading = false;
@override
void initState(){
  data=widget.products.data.map((e) => e).toList();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),

      body: _productList(),
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
      title: Text(widget.title,
          style: TextStyle(
              color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
      centerTitle: true,
    );
  }

  Widget _productList() {
    return Container(
      child: ListView.builder(
          itemCount: data.length,

          itemBuilder: (context, index) {
            return

                  Column(
                    children: <Widget>[


                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: ListTile(

                              leading: Container(
                                color: Colors.green,

                                height: 93.33,
                                width: 93.33,
                                child:

                                Image.network(
                                  '${data[index].productImages}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Text(
                                '${data[index].name}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: lblack,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    '${data[index].producer}',
                                    style: TextStyle(
                                          fontSize: 10.0,
                                          color: lblack,
                                          fontWeight: FontWeight.w100)),
                                  SizedBox(height: 16.66),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${data[index].cost}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: red,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                ],
                              ),


                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 11.0,
                                    width: 60.0,
                                    child: SmoothStarRating(
                                      rating: rating,
                                      color: Colors.amber,
                                      borderColor: Colors.grey,
                                      isReadOnly: false,
                                      size: 12,
                                      filledIconData: Icons.star,
                                      defaultIconData: Icons.star,
                                      starCount: data[index].rating,
                                      allowHalfRating: true,

                                      onRated: (value) {
                                        print("rating value -> $value");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {

                                ProductDetail product=await getProductDetail(data[index].id);
print("access Token");
                                print(widget.user);

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsPage(
                                          title: 'Product details page', id: data[index].id,productDetail:product,user:widget.user)));
                                print(widget.user);
                              },

                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                          ),
                        ],
                      ),


                    ],
                  // ),
            // )
            // ;
                  );
          },
          ),
    );
  }
  Future<ProductDetail> getProductDetail(int productId) async {

    final parameters = {
      'product_id': productId.toString(),
    };

    var url = (
        'http://staging.php-dev.in:8844/trainingapp/api/products/getDetail');

    String query = Uri(queryParameters: parameters).query;
    final requestUrl = url + "?" + query;
    final response = await http.get(Uri.parse(requestUrl));
    final jsonData = response.body;
    final res=productDetailFromJson(response.body)
    ;  print(jsonDecode(jsonData));
    return res;


  }
}