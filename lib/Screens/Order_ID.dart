import 'package:flutter/material.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:neo_store/model/order_detail_model.dart';
import 'package:http/http.dart' as http;

class Order_Id extends StatefulWidget {
  Order_Id({Key key, this.id, this.user}) : super(key: key);

  int id;
  RegisterResponseModel user;
  @override
  _Order_IdState createState() => _Order_IdState();
}

class _Order_IdState extends State<Order_Id> {
  // Dummy Product Data Here
  int _value = 1;

  final List myProducts = List.generate(100, (index) {
    return {"id": index, "title": "Product \#$index", "price": index + 1};
  });
  OrderDetail orderDetail;

  @override
  void initState() {
    getOrderDetails(
        accessToken: widget.user.data.accessToken,
        orderId: widget.id.toString());
    // TODO: implement initState
    super.initState();
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
          title: Text(widget.id.toString(),
              style: TextStyle(
                  color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.66, vertical: 16.66),
              child: Container(
                child: FutureBuilder<OrderDetail>(
                    future: getOrderDetails(
                        accessToken: widget.user.data.accessToken,
                        orderId: widget.id.toString()),
                    builder: (context, snapshot) {
                      orderDetail = snapshot.data;
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: orderDetail.data.order_details.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.grey[600]),
                          itemBuilder: (BuildContext ctx, index) {
                            return Column(children: [
                              Container(
                                child: ListTile(
                                  leading: Container(
                                    height: 90.0,
                                    width: 93.33,
                                    child: Image.network(
                                      orderDetail
                                          .data.order_details[index].prod_image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  title: Text(
                                    orderDetail
                                        .data.order_details[index].prod_name,
                                    style: TextStyle(
                                        fontSize: 23.66,
                                        color: lblack,
                                        fontWeight: FontWeight.w600),
                                  ), //data[index].title),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          orderDetail.data.order_details[index]
                                              .prod_name,
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: lblack,
                                              fontWeight: FontWeight.w100)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                                orderDetail
                                                    .data
                                                    .order_details[index]
                                                    .quantity
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: lblack,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Text(
                                              orderDetail.data.cost.toString()),
                                        ],
                                      ),
                                    ],
                                  ), //data[index].body),

                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [],
                                  ),
                                  // onTap: (){
                                  //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(title:'Product details page',user: widget.user,)));
                                  //   },
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                height: 66.667,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("TOTAL",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: gray,
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                        orderDetail
                                            .data.order_details[index].total
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: gray,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                              ),
                            ]);

                            // This will show up when the user performs dismissal action
                            // It is a red background and a trash icon

                            // );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
          ],
        ));
  }

  Future<OrderDetail> getOrderDetails(
      {String accessToken, String orderId}) async {
    var endPointUrl =
        "http://staging.php-dev.in:8844/trainingapp/api/orderDetail";
    Map<String, String> queryParams = {
      "order_id": orderId.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = endPointUrl + "?" + queryString;
    var response = await http.get(Uri.parse(requestUrl), headers: {
      "access_token": accessToken,
    });

    if (response.statusCode == 200) {
      final responseJson = orderDetailFromJson(response.body);
      print('accountDetailsFromJson');
      print(responseJson);
      return responseJson;
    } else {
      final responseJson = orderDetailFromJson(response.body);
      print(responseJson);
      return responseJson;
    }
  }
}
