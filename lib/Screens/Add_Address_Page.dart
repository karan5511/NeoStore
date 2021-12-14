import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Address_Page/Address_Bloc.dart';
import 'package:neo_store/Bloc/Address_Page/Address_Event.dart';
import 'package:neo_store/Bloc/Address_Page/Address_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/Add_Address_Repo.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:neo_store/model/order_model.dart';
import 'package:http/http.dart' as http;

class AddAddressPage extends StatefulWidget {
  AddAddressPage({Key key, this.user, this.order}) : super(key: key);

  RegisterResponseModel user;
  Order order;

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  String accessToken;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.grey[300],
        body: BlocProvider<AddressBloc>(
          create: (context) => AddressBloc(
            addressRepo: context.read<AddressAuthRepository>(),
          ),
          child: _form(),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    Navigator.pop(context, true);
    return null;
  }

  Future<Order> addAddress(String accessToken, String address) async {
    var url = Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/order');
    print(url);
    final response = await http.post(url, headers: {
      'access_token': accessToken
    }, body: {
      'address': address,
    });
    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = orderFromJson(response.body);

      print(response.body);
//  print(jsonBody.data);

      return jsonBody;
    } else {
      final jsonBody = orderFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: myRed1,
      title: Text(
        "Add Address",
        style: TextStyle(fontSize: 25.0),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _form() {
    return BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ADDRESS",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  _address(),
                  Text(
                    "CITY",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  _city(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CITY",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 26.0),
                            child: Container(
                              height: 40.0,
                              width: 150.0,
                              child: TextFormField(
                                controller: cityController,
                                decoration: InputDecoration(
                                  hintText: 'MUMBAI',
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorStyle: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "ZIP CODE",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 26.0),
                            child: Container(
                              height: 40.0,
                              width: 150.0,
                              child: TextFormField(
                                controller: zipCodeController,
                                decoration: InputDecoration(
                                  hintText: '10066',
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorStyle: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "STATE",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 26.0),
                            child: Container(
                              height: 40.0,
                              width: 150.0,
                              child: TextFormField(
                                controller: stateController,
                                decoration: InputDecoration(
                                  hintText: 'MAHARASHTRA',
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorStyle: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "COUNTRY",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 26.0),
                            child: Container(
                              height: 40.0,
                              width: 150.0,
                              child: TextFormField(
                                controller: countryController,
                                decoration: InputDecoration(
                                  hintText: 'INDIA',
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorStyle: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Container(
                        width: double.infinity,
                        height: 55.0,
                        child: BlocConsumer<AddressBloc, AddressState>(
                            listener: (context, state) {
                          if (state is SubmissionSuccess) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Order success'),
                            ));
                          }
                        }, builder: (context, state) {
                          return state is FormSubmittingState
                              ? CircularProgressIndicator()
                              // ignore: deprecated_member_use
                              : FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.red)),
                                  onPressed: () async {

                                    context.read<AddressBloc>().add(
                                        onPlaceOrderClicked(
                                            accessToken: '${widget.user.data.accessToken}',
                                            address: addressController.text));
                                    final String address =
                                        addressController.text;
                                    //
                                    await addAddress(
                                        widget.user.data.accessToken, address);
                                    Navigator.pop(context);

                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressListPage()));
                                  },
                                  color: myRed1,
                                  child: Text("PLACE ORDER",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _address() {
    return BlocConsumer<AddressBloc, AddressState>(listener: (context, state) {
      if (state is SubmissionSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Order success'),
        ));
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 26.0),
        child: TextFormField(
            controller: addressController,
            maxLines: 5,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              errorStyle: TextStyle(color: Colors.red),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            onChanged: (address) => context.read<AddressBloc>().add(
                OnAddressChanged(
                    accessToken: '${widget.user.data.accessToken}',
                    address: addressController.text))),
      );
    });
  }

  Widget _city() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 26.0),
      child: Container(
        height: 40.0,
        child: TextFormField(
          controller: landmarkController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'LANDMARK',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            errorStyle: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
