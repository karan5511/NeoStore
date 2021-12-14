import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Order_Details/Order_Details_Bloc.dart';
import 'package:neo_store/Bloc/Order_Details/Order_Details_Event.dart';

import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/OrderDetailsRepo.dart';
import 'package:neo_store/model/Product_List_model.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:neo_store/model/order_list_model.dart';

import 'Order_ID.dart';
import 'package:http/http.dart' as http;

class MyOrdersPage extends StatefulWidget {
  MyOrdersPage({Key key, this.title, this.user, this.products})
      : super(key: key);
  RegisterResponseModel user;
  ProductListResponseModel products;
  final String title;

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<OrderData> data;
  OrderList orderList;

  @override
  // void initState(){
  //   getOrder();
  //   super.initState();
  // }
  // getOrder() {
  //   Future.delayed(Duration(milliseconds: 1000), ()async{
  //     orderList = await getOrderList(accessToken: widget.user.data.accessToken);
  //
  //   });
  //
  // }

  // @override
  // void didChangeDependencies() {
  //   Future.delayed(Duration(milliseconds: 1000), (){getOrder();});
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text('My Orders',
              style: TextStyle(
                  color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
          centerTitle: true,
        ),
        // drawer:,
        body: BlocProvider<OrderDetailsBloc>(
          create: (context) => OrderDetailsBloc(
            orderDetailRepo: context.read<OrderDetailsRepository>(),
          ),
          child: FutureBuilder<OrderList>(
              future:
                   getOrderList(accessToken: widget.user.data.accessToken),
              builder: (context, snapshot) {
                orderList = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: orderList.data.length,
                      itemExtent: 92.44,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '${orderList.data[index].id}',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: lblack,
                                          fontWeight: FontWeight.w600),
                                    ), //data[index].title),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('${orderList.data[index].created}',
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                color: lblack,
                                                fontWeight: FontWeight.w100)),
                                        SizedBox(height: 10.0),
                                      ],
                                    ), //data[index].body),

                                    trailing:
                                        Text(" ${orderList.data[index].cost}"),
                                    onTap: () {
                                      context.read<OrderDetailsBloc>().add(
                                          OnOrderDetailsClicked(
                                              accessToken:
                                                  widget.user.data.accessToken,
                                              id: orderList.data[index].id
                                                  .toString()));
                                      print("bloc working");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Order_Id(
                                                  id: orderList.data[index].id,
                                                  user: widget.user)));
                                    },
                                    dense: true,
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}

Future<OrderList> getOrderList({String accessToken}) async {
  final url = 'http://staging.php-dev.in:8844/trainingapp/api/orderList';

  final response =
      await http.get(Uri.parse(url), headers: {'access_token': accessToken});
  if (response.statusCode == 200) {
    final responseJson = orderListFromJson(response.body);
    print('accountDetailsFromJson');
    print(responseJson);
    return responseJson;
  } else {
    final responseJson = orderListFromJson(response.body);
    print(responseJson);
    return responseJson;
  }
}
