import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Account_Page/Account_Bloc.dart';
import 'package:neo_store/Bloc/Account_Page/Account_Event.dart';
import 'package:neo_store/Bloc/Account_Page/Account_State.dart';
import 'package:neo_store/Bloc/Edit_Account/Edit_Account_Event.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/Fetch_Account_repo.dart';
import 'package:neo_store/model/Fetch_Account_Model.dart';
import 'package:neo_store/model/Register_model.dart';

import 'Edit_page.dart';
import 'Reset_password.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key key, this.title, this.user}) : super(key: key);

  RegisterResponseModel user;

  final String title;

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  AccDetailsRepo accDetailsRepo;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myRed1,
      bottomSheet: _bottomSheet(),
      appBar: _appbar(),
      body: BlocProvider<AccBloc>(
        create: (context) => AccBloc(
          accAuthRepo: context.read<AccDetailsRepo>(),
        ),
        child: _form(),
      ),
    );
  }

  // Future<AccountDetails> getAccountDetails({String accessToken}) async {
  //   final url =
  //       'http://staging.php-dev.in:8844/trainingapp/api/users/getUserData';
  //
  //   final response =
  //       await http.get(Uri.parse(url), headers: {'access_token': accessToken});
  //   if (response.statusCode == 200) {
  //     final responseJson = accountDetailsFromJson(response.body);
  //     print('accountDetailsFromJson');
  //     print(responseJson);
  //     return responseJson;
  //   } else {
  //     final responseJson = jsonDecode(response.body);
  //     print(responseJson);
  //     return responseJson;
  //   }
  // }

  Widget _bottomSheet() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 52,
        child: Text(
          "RESET PASSWORD",
          style: TextStyle(color: gray, fontSize: 17.0),
        ),
      ),
      onTap: () async {
        // await accDetailsRepo.getAccountDetails(
        //     accessToken: '${widget.user.data.accessToken}');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPage(
                      user: widget.user,
                    )));
      },
    );
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
      title: Text('My Account',
          style: TextStyle(
              color: white, fontWeight: FontWeight.w700, fontSize: 25.0)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context, true);
        },
      ),
    );
  }

  Widget _profilePic() {
    return Container(
      height: 133.0,
      width: 133.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: white),
          image: DecorationImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0JhaimSD1ayvA9vffVRcueFMd8MqD5cJH9A&usqp=CAU'),
            fit: BoxFit.fill,
          )),
    );
  }

  Widget _firstName() {
    return TextFormField(
      controller: firstName,
      enabled: false,
      decoration: InputDecoration(
        hintText: '${widget.user.data.firstName}',
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: white,
        ),
      ),
    );
  }

  Widget _lastName() {
    return TextFormField(
      controller: lastName,
      enabled: false,
      decoration: InputDecoration(
        hintText: '${widget.user.data.lastName}',
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: white,
        ),
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      controller: email,
      enabled: false,
      decoration: InputDecoration(
        hintText: '${widget.user.data.email}',
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: white,
        ),
      ),
    );
  }

  Widget _phoneNo() {
    return TextFormField(
      controller: phoneNo,
      enabled: false,
      decoration: InputDecoration(
        hintText: '${widget.user.data.phoneNo}',
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        prefixIcon: Icon(
          Icons.phone_android,
          color: white,
        ),
      ),
    );
  }

  Widget _dob() {
    return TextFormField(
      controller: dob,
      enabled: false,
      decoration: InputDecoration(
        hintText: '${widget.user.data.dob}',
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        prefixIcon: Icon(
          Icons.cake,
          color: white,
        ),
      ),
    );
  }

  Widget _editButton() {
    return BlocConsumer<AccBloc, AccState>(listener: (context, state) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditPage(
                    accountDetails: state.details,
                    user: widget.user,
                  )));
    }, builder: (context, state) {
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.white)),
        height: 47.33,
        minWidth: 400.0,
        color: white,
        onPressed: () async {
          context.read<AccBloc>().add(
              OnEditButtonClicked(token: '${widget.user.data.accessToken}'));
        },
        child: Text(
          "EDIT PROFILE",
          style: TextStyle(color: myRed1, fontSize: 26),
        ),
      );
    });
  }

  Widget _form() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _profilePic(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 33,
                        right: 33,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 49.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          _firstName(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _lastName(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _email(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _phoneNo(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _dob(),
                          SizedBox(
                            height: 20,
                          ),
                          // ignore: deprecated_member_use
                          _editButton(),
                          SizedBox(
                            height: 20,
                          ),
                          // ignore: deprecated_member_use

                          SizedBox(
                            height: 80,
                          ),
                        ],
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
  }
}
