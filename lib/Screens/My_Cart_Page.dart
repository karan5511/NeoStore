import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_Event.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_State.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_bloc.dart';

import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/cart_repo.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:neo_store/model/cart_list_model.dart';
import 'package:neo_store/model/my_cart_model.dart';
import 'package:http/http.dart' as http;

import 'Add_Address_Page.dart';

class MyCart extends StatefulWidget {
  MyCart({Key key, this.user}) : super(key: key);
  RegisterResponseModel user;
  Cart cart;
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  CartItems cartItems;
  List<Data> data;

  @override
  void initState() {
    getCartItems();

    print(widget.user.data.accessToken);
    super.initState();
  }

  getCartItems() async {
    cartItems = await getCartList(widget.user.data.accessToken);
    print(cartItems);
    data = cartItems.data.map((e) => e).toList();
    print(cartItems.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
          title: Text('My Cart',
              style: TextStyle(
                  color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
          centerTitle: true,
        ),
        body: BlocProvider<CartListBloc>(
            create: (context) => CartListBloc(
                  cartRepo: context.read<CartAuthRepository>(),
                ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      child: FutureBuilder<CartItems>(
                          future: getCartList(widget.user.data.accessToken),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.data == null) {
                                return Center(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://professionalscareer.com/assets/images/emptycart.png")),
                                );
                              } else {
                                return Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: data.length,
                                      itemExtent: 103.33,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext ctx, index) {
                                        // Display the list item
                                        return Dismissible(
                                          key: UniqueKey(),

                                          // only allows the user swipe from right to left
                                          direction:
                                              DismissDirection.endToStart,

                                          // Remove this product from the list

                                          onDismissed: (_) {
                                            setState(() {
                                              context.read<CartListBloc>().add(
                                                  OnDeleteSwiped(
                                                      accessToken: widget.user
                                                          .data.accessToken,
                                                      productId: data[index]
                                                          .product_id
                                                          .toString()));

                                              data.clear();
                                              context.read<CartListBloc>().add(
                                                  OnShowCartList(
                                                      accessToken: widget.user
                                                          .data.accessToken));
                                            });
                                          },

                                          child: Column(
                                            children: [
                                              Container(
                                                child: ListTile(
                                                  leading: Container(
                                                    height: 90.0,
                                                    width: 93.33,
                                                    child: Image.network(
                                                        '${data[index].product.product_images}',
                                                        fit: BoxFit.fill),
                                                  ),
                                                  title: Text(
                                                    "${data[index].product.name}",
                                                    style: TextStyle(
                                                        fontSize: 18.00,
                                                        color: lblack,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ), //data[index].title),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${data[index].product.product_category}",
                                                          style: TextStyle(
                                                              fontSize: 10.0,
                                                              color: lblack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100)),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            width: 40,
                                                            color: grey2,
                                                            child: BlocBuilder<
                                                                    CartListBloc,
                                                                    CartState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                              return DropdownButtonHideUnderline(
                                                                child: DropdownButton<
                                                                        String>(
                                                                    value: data[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    items: [
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "1"),
                                                                        value:
                                                                            "1",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "2"),
                                                                        value:
                                                                            "2",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "3"),
                                                                        value:
                                                                            "3",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "4"),
                                                                        value:
                                                                            "4",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "5"),
                                                                        value:
                                                                            "5",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "6"),
                                                                        value:
                                                                            "6",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "7"),
                                                                        value:
                                                                            "7",
                                                                      ),
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        child: Text(
                                                                            "8"),
                                                                        value:
                                                                            "8",
                                                                      ),
                                                                    ],
                                                                    onChanged:
                                                                        (value) {
                                                                      print(
                                                                          value);
                                                                      setState(
                                                                          () {
                                                                        value =
                                                                            value;

                                                                        editCartData(
                                                                            widget.user.data.accessToken,
                                                                            value,
                                                                            data[index].product_id.toString());
                                                                      });
                                                                    }),
                                                              );
                                                            }),
                                                          ),
                                                          Text(
                                                              "${data[index].product.sub_total}"),
                                                        ],
                                                      ),
                                                    ],
                                                  ), //data[index].body),

                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [],
                                                  ),
                                                  // onTap: (){
                                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(title:'Product details page',)));},
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1.0,
                                              ),
                                            ],
                                          ),

                                          // This will show up when the user performs dismissal action
                                          // It is a red background and a trash icon

                                          background: Container(
                                            //  color: Colors.red,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            alignment: Alignment.centerRight,
                                            child: FloatingActionButton(
                                              child: Icon(Icons.delete),
                                              backgroundColor: myRed1,
                                              onPressed: () {
                                                print('karan');
                                              },
                                              mini: true,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 20.0),
                                      height: 66.667,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('TOTAL',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: gray,
                                                  fontWeight: FontWeight.w600)),
                                          Text('Rs ${snapshot.data.total}',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: gray,
                                                  fontWeight: FontWeight.w600))
                                          //
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                  BlocBuilder<CartListBloc, CartState>(
                      builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      width: double.infinity,
                      height: 55.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () {
                          Navigator.push(
                              // context.read<CartListBloc>().add(onOrder)
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddAddressPage(user: widget.user)));
                        },
                        color: buttonRed,
                        child: Text("ORDER NOW",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  }),
                ],
              ),
            )));
  }

  Future<CartItems> getCartList(String accessToken) async {
    var url = ('http://staging.php-dev.in:8844/trainingapp/api/cart');

    final response =
        await http.get(Uri.parse(url), headers: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final responseJson = cartItemsFromJson(response.body);
      print('cartDetails');
      print(responseJson);
      return responseJson;
    } else {
      final responseJson = cartItemsFromJson(response.body);
      print(responseJson);
      return responseJson;
    }
  }

  Future<Cart> editCartData(
      String accessToken, String quants, String id) async {
    var url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/editCart');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'product_id': id,
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
}
