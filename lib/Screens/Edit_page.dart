
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Screens/My_account_page.dart';
import 'package:neo_store/model/Fetch_Account_Model.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:http/http.dart' as http;

import 'Login_Page.dart';

class EditPage extends StatefulWidget {
  AccountDetails accountDetails;
  EditPage({Key key, this.accountDetails,this.user}) : super(key: key);
  RegisterResponseModel user;

  @override
  _EditPageState createState() => _EditPageState();

}

class _EditPageState extends State<EditPage> {
  TextEditingController email = TextEditingController();
  TextEditingController profilePic = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  Future<RegisterResponseModel> addData(String accessToken) async {
    var url = Uri.parse(
        'http://staging.php-dev.in:8844/trainingapp/api/users/update');
    print(url);
    final response = await http.post(url, headers: {'access_token': accessToken},body: {
      'dob': dob.text,
      'profile_pic': profilePic.text,
      'email': email.text,
      'phone_no': phoneNo.text,
      'first_name' : fName.text,
      'last_name' : lName.text,
    });
// print(response.body);
    int responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      final jsonBody = userFromJson(response.body);

      print(response.body);
//  print(jsonBody.data);

      return jsonBody;
    } else {
      final jsonBody = userFromJson(response.body);

      print(response.body);

      return jsonBody;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          backgroundColor: myRed1,
          elevation: 0.0,
          title: Text('Edit Profile',
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
        ),
        backgroundColor: myRed1,
        body: Container(
            child: Padding(
                padding: EdgeInsets.only(top: 150, bottom: 10.0),
                child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
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
                      ),
                      Container(
                          child: Column(children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                  left: 33,
                                  right: 33,
                                ),
                                child: Column(children: <Widget>[
                                  SizedBox(
                                    height: 49.0,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: fName,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person, color: Colors.white,),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      errorBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                                      errorStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: lName,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person, color: Colors.white,),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      errorBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                                      errorStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: email,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email, color: Colors.white,),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      errorBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      hintText: 'Email Address',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                                      errorStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: phoneNo,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone_android, color: Colors.white,),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      errorBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                                      errorStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: dob,
                                    style: TextStyle(color: Colors.white),
                                    //  readOnly: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.cake, color: Colors.white,),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      errorBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,),),
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                                      errorStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.white)),
                                    height: 47.33,
                                    minWidth: 400.0,
                                    color: white,
                                    onPressed: () async {
                                      print('karan');

                                      RegisterResponseModel detail = await addData('${widget.user.data.accessToken}');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyAccountPage(
                                                title: "My Account Page",user: widget.user,
                                              )));
                                      print(detail);
                                    },
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: myRed1, fontSize: 26),
                                    ),
                                  ),
                                ]))
                          ]))
                    ])))));
  }
}
