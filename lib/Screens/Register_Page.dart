import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Event.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_State.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_bloc.dart';
import 'package:neo_store/Repository/RegisterAuthenticationRepo.dart';
import 'package:neo_store/model/Register_model.dart';

import 'package:neo_store/Colors/color.dart';

import 'Home_Page.dart';
import 'Login_Page.dart';

class RegisterPage extends StatefulWidget {
  final String title;


  RegisterPage({Key key, this.title,}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  UserData userData;



  RegisterAuthRepository registerAuthRepo;


  bool isLoading = false;
  bool _check = false;
  bool isValidateForm1 = false;
  String gender = '';
  bool visible = true;
  bool visible2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myRed1,
      appBar: appbar(),
      body: BlocProvider(
        create: (context) => RegisterBloc(
          registerAuthRepo: context.read<RegisterAuthRepository>(),
        ),
        child: registerForm(),
      ),
    );
  }

  Widget registerForm() {

      return Padding(
        padding: EdgeInsets.only(top: 50, bottom: 10.0),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: registerFormKey,
              child: Column(
                children: <Widget>[
                  _header(),
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
                        _firstname(),
                        SizedBox(
                          height: 13,
                        ),
                        _lastname(),
                        SizedBox(
                          height: 13,
                        ),
                        _email(),
                        SizedBox(
                          height: 13,
                        ),
                        _password(),
                        SizedBox(
                          height: 13,
                        ),
                        _confirmPassword(),
                        SizedBox(
                          height: 23.0,
                        ),
                        _gender(),
                        SizedBox(
                          height: 23.0,
                        ),
                        _phoneNumber(),
                        SizedBox(
                          height: 23.0,
                        ),
                        _termsNconditions(),
                        _loginButton(

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }

  Widget appbar() {
    return AppBar(
      backgroundColor: myRed1,

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0.0,
      title: Text('Register',
          style: TextStyle(
            // color: white,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 25.0)),
      centerTitle: true,
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

  Widget _firstname() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: firstName,
        keyboardType: TextInputType.emailAddress,
        cursorColor: white,

        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: white

              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: white

              )),
          border: OutlineInputBorder(
            borderSide: BorderSide(

                color: white),
          ),
          errorStyle: TextStyle(

              color: black),
          prefixIcon: Icon(
            Icons.person,
            color: white,

          ),
          hintText: 'First Name',
          hintStyle: TextStyle(color: white, fontSize: 18.0),
        ),
        validator: (fName) {
          if (fName == "" || fName.isEmpty) {
            return "Please Enter Your First Name";
          } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(fName)) {
            return "Invalid Name";
          }
          return null;
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterFirstNameChanged(firstName: value)),
      );
    });
  }

  Widget _lastname() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: lastName,
        keyboardType: TextInputType.emailAddress,

        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,

            ),
          ),
          errorStyle: TextStyle(
            color: Colors.black,

          ),
          prefixIcon: Icon(
            Icons.person,

            color: Colors.white,
          ),
          hintText: 'Last Name',
          hintStyle: TextStyle(
              color: Colors.white,

              fontSize: 18.0),
        ),
        validator: (lName) {
          if (lName == "" || lName.isEmpty) {
            return "Please Enter Your Last Name";
          } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(lName)) {
            return "Invalid Name";
          }
          return null;
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterLastNameChanged(lastName: value)),
      );
    });
  }

  Widget _email() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        // cursorColor: white,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(

                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,

            ),
          ),
          errorStyle: TextStyle(
            color: Colors.black,
          ),
          prefixIcon: Icon(
            Icons.email,

            color: Colors.white,
          ),
          hintText: 'Email',
          hintStyle: TextStyle(
              color: Colors.white,

              fontSize: 18.0),
        ),
        validator: (mail) {
          if (mail == "" || mail.isEmpty) {
            return "Please Enter E-mail";
          } else if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(mail)) {
            return "Invalid Email";
          }
          return null;
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterEmailChanged(email: value)),
      );
    });
  }

  Widget _password() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: password,
        keyboardType: TextInputType.emailAddress,

        obscureText: visible,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,

            ),
          ),
          errorStyle: TextStyle(
            color: Colors.white,

          ),
          prefixIcon: Icon(
            Icons.lock, color: Colors.white,

          ),
          suffixIcon: IconButton(
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,

              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            },
          ),
          hintText: 'Password',
          hintStyle: TextStyle(
              color: Colors.white,

              fontSize: 18.0),
        ),
        validator: (pass) {
          if (pass == "" || pass.isEmpty) {
            return 'Please Enter Password';
          } else if (pass.length <= 6) {
            return 'Password should be greater than 6';
          }
          return null;

        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterPasswordChanged(password: value)),

      );

    });
  }

  Widget _confirmPassword() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: confirmPassword,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,

        obscureText: visible2,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,

              )),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,

            ),
          ),
          errorStyle: TextStyle(
            color: Colors.white,

          ),
          prefixIcon: Icon(
            Icons.lock, color: Colors.white,

          ),
          suffixIcon: IconButton(
            icon: Icon(
              visible2 ? Icons.visibility : Icons.visibility_off,

              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                visible2 = !visible2;
              });
            },
          ),
          hintText: 'Confirm Password',
          hintStyle: TextStyle(

              color: Colors.white,
              fontSize: 18.0),
        ),
        validator: (cpass) {
          if (cpass == "" || cpass.isEmpty) {
            return 'Please Enter Password';
          } else if (cpass.length < 6) {
            return 'Password should be greater than 6';
          } else
            return null;
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterConfirmPasswordChanged(confirmPassword: value)),
      );
    });
  }

  Widget _gender() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Container(
        margin: new EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Gender',
              style: TextStyle(
                  color: Colors.white,

                  fontSize: 16.0),
            ),
            new Radio(
              value: 'M',
              groupValue: gender,
              onChanged: (_value) {
                setState(() {
                  gender = _value;
                });
                context.read<RegisterBloc>().add(RegisterGenderChanged(gender: _value));
              },
              activeColor: Colors.white,
            ),
            new Text(
              'Male',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            new Radio(
              value: 'F',
              groupValue: gender,
              onChanged: (_value) {
                setState(() {
                  gender = _value;
                });
                context.read<RegisterBloc>().add(RegisterGenderChanged(gender: _value));

              },
              activeColor: Colors.white,
            ),
            new Text(
              'Female',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            isValidateForm1 && gender == null
                ? Text(
              'Required',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            )
                : Container(),
            SizedBox(
              height: 23.0,
            ),
          ],
        ),
      );
    });
  }

  Widget _phoneNumber() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: phoneNo,
        keyboardType: TextInputType.number,

        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(

                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(

                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderSide: BorderSide(

              color: Colors.white,
            ),
          ),
          errorStyle: TextStyle(

            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.phone_android,
            // color: white,
            color: Colors.white,
          ),
          hintText: 'Phone Number',
          hintStyle: TextStyle(
              color: Colors.white,

              fontSize: 18.0),
        ),
        validator: (phone) {
          if (phone == "" || phone.isEmpty) {
            return "Enter Phone Number";
          } else if (phone.length < 9) {
            return "Enter min 10 digits";
          }
          return null;
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterPhoneNumberChanged(phoneNo: value)),
      );
    });
  }

  Widget _termsNconditions() {
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: _check,
            onChanged: (value) {
              setState(() {
                _check = value;
              });
            },

            checkColor: Colors.black,
          ),
          RichText(
            text: TextSpan(
              text: 'I agree the ',
              style: TextStyle(fontSize: 13.0, color: Colors.white),
              children: [
                TextSpan(
                    text: "Terms & Condition",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
            ),
          ),
        ],
      );

  }

  Widget _loginButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state is FormSubmittingState
          ? CircularProgressIndicator()
          : FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.white)),
        height: 47.33,
        minWidth: 400.0,

        color: Colors.white,
        onPressed: () async {
          print('karan');
          context.read<RegisterBloc>().add(RegisterSubmitted(
              firstName: firstName.text,
              lastName: lastName.text,
              email: email.text,
              password: password.text,
              confirmPassword: confirmPassword.text,
              gender: gender,
              phoneNumber: phoneNo.text
          ));

         if(registerFormKey.currentState.validate()){


      if(state is SubmissionSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Successfull'),));
      Navigator.pop(context);
      }
      else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
      'Both Passwords doesn\t match. Please Check Onces...!! '),
      ));
      }



            }


          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => LoginPage(
                    title: 'Login Page',
                  )));
        },
        child: Text(
          "REGISTER",
          style: TextStyle(
              color: Colors.red,
              // color: myRed1,
              fontSize: 26),
        ),
      );
    });
  }



}
