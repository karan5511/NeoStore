

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Forgot_Password/ForgotPasswordRepo.dart';
import 'package:neo_store/Bloc/Forgot_Password/Forgot_Password_Event.dart';
import 'package:neo_store/Bloc/Forgot_Password/Forgot_Password_State.dart';
import 'package:neo_store/Bloc/Forgot_Password/Forgot_Password_bloc.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/model/Register_model.dart';
import 'package:http/http.dart' as http;


import 'login_page.dart';

// ignore: must_be_immutable
class ForgotPage extends StatefulWidget {
  ForgotPage({Key key,  this.title}) : super(key: key);

  final String title;


  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController email = TextEditingController();

  // ignore: non_constant_identifier_names
  final ForgotPasskey = GlobalKey<FormState>();
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myRed1,
      body:
      BlocProvider<ForgotPasswordBloc>(
        create: (context) => ForgotPasswordBloc(
              forgotPasswordAuthRepo: context.read<ForgotPasswordAuthRepository>(),
            ),
       child: Padding(
          padding: EdgeInsets.only(top: 150, bottom: 10.0),
          child: SingleChildScrollView(
            child: Container(
              child: _form(),
            ),
          ),
        ),

      )

  );

  }

  Widget _header() {
    return Container(
      child: Text(
        'NeoSTORE',
        style: TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.w700,
          color: white,
        ),
      ),
    );
  }

  Widget _form() {
    // return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      // listener: (context, state) {
      //   final forgotPasswordState = state.forgotPasswordState;
      //   // if (formStatus is SubmissionFailed) {
      //   //   _showSnackBar(context, formStatus.exception.toString());
      //   // }
      // },


      // child:
      return  Form(

        key: ForgotPasskey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 33,
                right: 33,
              ),
              child: Column(
                children: <Widget>[
                  _header(),
                  SizedBox(
                    height: 49.0,
                  ),
                  _forgotPassword(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _submit(),
                ],
              ),
            ),
          ],
        ),
      );
    // );
  }


  Widget _forgotPassword() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            cursorColor: white,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: white)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: white)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: white),
              ),
              errorStyle: TextStyle(color: black),
              prefixIcon: Icon(
                Icons.person,
                color: white,
              ),
              hintText: 'Email Address',
              hintStyle: TextStyle(color: white, fontSize: 18.0),
            ),
            validator: (usermail) {
              if (usermail == "" || usermail.isEmpty) {
                return "Please Enter E-mail";
              }



              return null;
            },
          );
        }
    );
  }

  Widget _submit() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return state is FormSubmissionState
              ? CircularProgressIndicator()

              :
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white)),
            height: 47.33,
            minWidth: 400.0,
            color: white,
            onPressed: () async {
              print('tapped');
              context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitted(email: email.text));




          if(state is SubmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password sent Successfully'),));
          Navigator.pop(context);
          }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LoginPage(
                        title: 'Login Page',
                      )));
          }



            ,

            child: Text(
              "SUBMIT",
              style: TextStyle(color: myRed1, fontSize: 26),
            ),
          );
        }
    );
  }
}