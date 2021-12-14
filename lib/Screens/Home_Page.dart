import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_Event.dart';
import 'package:neo_store/Bloc/Cart_Page/Cart_bloc.dart';
import 'package:neo_store/Bloc/Home_Page/Home_Event.dart';
import 'package:neo_store/Bloc/Home_Page/Home_State.dart';
import 'package:neo_store/Bloc/Home_Page/Home_bloc.dart';
import 'package:neo_store/Bloc/Order_List_Page/Ordre_List_Bloc.dart';
import 'package:neo_store/Bloc/Order_List_Page/Ordre_List_Event.dart';
import 'package:neo_store/Bloc/Order_List_Page/Ordre_List_State.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/HomeAuthenticationRepo.dart';

import 'package:neo_store/Repository/orders_repo.dart';

import 'package:neo_store/Screens/Store_Locator.dart';
import 'package:neo_store/model/Product_List_model.dart';
import 'package:neo_store/model/Register_model.dart';

import 'Login_Page.dart';
import 'My_Cart_Page.dart';

import 'My_Orders_Page.dart';
import 'My_account_page.dart';
import 'Product_List_Page.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  RegisterResponseModel user;
  HomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNumber = 1;

  Future<ProductListResponseModel> getProductList(String productType) async {
    final Map<String, String> productTypes = {
      "tables": "1",
      "chairs": "2",
      "sofas": "3",
      "cupboards": "4",
    };
    final parameters = {
      'product_category_id': productTypes[productType],
      'limit': '10',
      'page': pageNumber.toString()
    };

    var url =
        ('http://staging.php-dev.in:8844/trainingapp/api/products/getList');
    print(url);
    String query = Uri(queryParameters: parameters).query;
    final requestUrl = url + "?" + query;
    final response = await http.get(Uri.parse(requestUrl));
    final jsonData = response.body;
    final res = productFromJson(response.body);
    print(res);
    return res;
  }

  HomeAuthRepo homeAuthRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      backgroundColor: myRed1,
      drawer: BlocProvider(
        create: (context) => OrderListBloc(
          orderListRepo: context.read<OrderListRepo>(),
        ),
        child: _drawer(),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          homeAuthRepo: context.read<HomeAuthRepo>(),
        ),
        child: _form(),
      ),
    );
  }

  Widget _form() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: SingleChildScrollView(
          child: Container(
            color: white,
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      _carousel(),
                      SizedBox(
                        height: 13.0,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 13.33,
                            right: 15.33,
                          ),
                          color: white,
                          height: 600,
                          child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0,
                              ),
                              children: [
                                _table(),
                                _sofas(),
                                _chairs(),
                                _cupboards(),
                                SizedBox(height: 20),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _appbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      backgroundColor: myRed1,
      elevation: 0.0,
      title: Text('NeoSTORE',
          style: TextStyle(
              color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
      centerTitle: true,
    );
  }

  Widget _drawer() {
    return BlocBuilder<OrderListBloc, OrderListState>(builder: (context, state) {
      return Drawer(
        child: Container(
          color: black,
          child: ListView(children: <Widget>[
            DrawerHeader(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 83.33,
                        width: 83.33,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2.0, color: white),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU'),
                              fit: BoxFit.fill,
                            )),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text('Karan Singh',
                          style: TextStyle(color: white, fontSize: 23.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'karan@neosoftmail.com',
                        style: TextStyle(
                            color: white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: black,
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              tileColor: black,
              title: Text(
                "My Cart",
                style: TextStyle(fontSize: 16.0, color: white),
              ),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 28.0,
              ),
              trailing: Container(
                height: 26.0,
                width: 26.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: myRed1,
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
              onTap: () {
                // context
                //     .read<CartListBloc>()
                //     .add(OnShowCartList(accessToken: widget.user.data.accessToken) );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCart(
                              user: widget.user,
                            )));
                print(widget.user);
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              tileColor: black,
              title: Text(
                "Tables",
                style: TextStyle(fontSize: 16.0, color: white),
              ),
              leading: Container(
                width: 28.0,
                height: 28.0,
                child: Image.asset('asset/images/table.png'),
              ),
              onTap: () async {
                ProductListResponseModel product =
                    await getProductList('tables');
                print('product list');
                print(product);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductListPage(title: 'Sofa', products: product)));
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
                tileColor: black,
                title: Text(
                  'Sofas',
                  style: TextStyle(fontSize: 16.0, color: white),
                ),
                leading: Container(
                  width: 28.0,
                  height: 28.0,
                  child: Image.asset('asset/images/sofa.png'),
                ),
                onTap: () async {
                  ProductListResponseModel product =
                      await getProductList('sofas');
                  print('product list');
                  print(product);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage(
                              title: 'My Product Page', products: product)));
                }),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
                tileColor: black,
                title: Text(
                  "Chairs",
                  style: TextStyle(fontSize: 16.0, color: white),
                ),
                leading: Container(
                  width: 28.0,
                  height: 28.0,
                  child: Image.asset('asset/images/chair.png'),
                ),
                onTap: () async {
                  ProductListResponseModel product =
                      await getProductList('chairs');
                  print('product list');
                  print(product);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage(
                              title: 'Chairs', products: product, user: widget.user )));
                }),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
                tileColor: black,
                title: Text(
                  "Cupboards",
                  style: TextStyle(fontSize: 16.0, color: white),
                ),
                leading: Container(
                  width: 28.0,
                  height: 28.0,
                  child: Image.asset('asset/images/cupboard.png'),
                ),
                onTap: () async {
                  ProductListResponseModel product =
                      await getProductList('cupboards');
                  print('product list');
                  print(product);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage(
                              title: 'My Product Page',
                              user: widget.user,
                              products: product)));
                }),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              tileColor: black,
              title: Text(
                "My Account",
                style: TextStyle(fontSize: 16.0, color: white),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.white,
                size: 28.0,
              ),
              onTap: () {
                print(widget.user);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAccountPage(
                            title: 'My Account Page', user: widget.user)));
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              tileColor: black,
              title: Text(
                "Store locator",
                style: TextStyle(fontSize: 16.0, color: white),
              ),
              leading: Icon(
                Icons.location_pin,
                color: Colors.white,
                size: 28.0,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreLocator(

                            )));
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              tileColor: black,
              title: Text(
                "My Orders",
                style: TextStyle(fontSize: 16.0, color: white),
              ),
              leading: Icon(
                Icons.list,
                color: Colors.white,
                size: 28.0,
              ),
              onTap: () {
                // context.read<HomeBloc>().add(OnHomeButtonClicked());
                context
                    .read<OrderListBloc>().add(OnMyOrdersClicked(accessToken: '${widget.user.data.accessToken}'));
              print(widget.user.data.accessToken);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOrdersPage(
                              title: 'Orders page',
                              user: widget.user,
                            )));
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              tileColor: black,
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 16.0, color: white),
              ),
              leading: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 28.0,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(
                              title: 'Login page',
                            )));
              },
            ),
          ]),
        ),
      );
    });
  }

  Widget _carousel() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
        height: 228,
        width: 600,
        child: Carousel(
            overlayShadowColors: black,
            dotColor: myRed1,
            dotBgColor: Colors.transparent,
            dotIncreasedColor: Colors.grey.shade800,
            noRadiusForIndicator: true,
            indicatorBgPadding: 4,
            dotSize: 7,
            images: [
              Image.asset(
                "asset/images/table1.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "asset/images/sofa1.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "asset/images/cupboards1.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "asset/images/chair1.jpg",
                fit: BoxFit.cover,
              ),
            ]),
      );
    });
  }

  Widget _table() {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.product != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductListPage(
                      title: 'tables',
                      user: widget.user,
                      products: state.product,
                    )));
      }
    }, builder: (context, state) {
      return InkWell(
        onTap: () async {
          print(widget.user);
          ProductListResponseModel product = await getProductList('tables');

          print('product list');
          print(product);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductListPage(
                      title: 'Tables', user: widget.user, products: product)));
        },
        child: Container(
            padding:
                EdgeInsets.only(left: 5.5, top: 11, right: 13, bottom: 5.5),
            color: myRed1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Tables",
                        style: TextStyle(
                            fontSize: 23.0,
                            color: white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'asset/images/table.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }

  Widget _sofas() {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.product != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductListPage(
                      title: 'sofas',
                      user: widget.user,
                      products: state.product,
                    )));
      }
    }, builder: (context, state) {
      return InkWell(
        onTap: () async {
          context.read<HomeBloc>().add(OnHomeButtonClicked(id: 'sofas'));
          // ProductListResponseModel product =
          //     await getProductList('sofas');
          print('product list');
          // print(product);

          print(widget.user);
        },
        child: Container(
            padding:
                EdgeInsets.only(left: 5.5, top: 11, right: 13, bottom: 5.5),
            color: myRed1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'asset/images/sofa.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Sofas",
                          style: TextStyle(
                              fontSize: 23.0,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }

  Widget _chairs() {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.product != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductListPage(
                      title: 'chairs',
                      user: widget.user,
                      products: state.product,
                    )));
      }
    }, builder: (context, state) {
      return InkWell(
        onTap: () async {
          context.read<HomeBloc>().add(OnHomeButtonClicked(id: 'chairs'));

          print('product list');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductListPage(
                      title: 'Chairs',
                      user: widget.user,
                      products: state.product)));
        },
        child: Container(
            padding:
                EdgeInsets.only(left: 5.5, top: 11, right: 13, bottom: 5.5),
            color: myRed1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Chairs",
                          style: TextStyle(
                              fontSize: 23.0,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'asset/images/chair.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }

  Widget _cupboards() {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.product != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductListPage(
                      title: 'cupboards',
                      user: widget.user,
                      products: state.product,
                    )));
      }
    }, builder: (context, state) {
      return InkWell(
        onTap: () async {
          context.read<HomeBloc>().add(OnHomeButtonClicked(id: 'cupboards'));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductListPage(
                      title: 'Cupboards',
                      user: widget.user,
                      products: state.product)));
        },
        child: Container(
            padding:
                EdgeInsets.only(left: 5.5, top: 11, right: 13, bottom: 5.5),
            color: myRed1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'asset/images/cupboard.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Cupboard",
                          style: TextStyle(
                              fontSize: 21.0,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }
}
