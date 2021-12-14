import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Login/Login_Event.dart';
import 'package:neo_store/Bloc/Login/Login_State.dart';
import 'package:neo_store/Bloc/Login/Login_bloc.dart';
import 'package:neo_store/Bloc/Registration_bloc/Register_Form_Submission.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/loginAuthenticationRepo.dart';
import 'package:neo_store/model/Register_model.dart';


import 'package:neo_store/screens/Register_Page.dart';
import 'Forgot_Password_Page.dart';

import 'Home_Page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  var loginFormKey ;
  bool isLoading = false;

  @override
  void initState() {
    loginFormKey = GlobalKey<FormState>();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myRed1,
      // bottomSheet: _addAnAccount(),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          loginAuthRepo: context.read<LoginAuthRepository>(),
        ),
        child: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: EdgeInsets.only(top: 150, bottom: 10.0),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 33,
                  right: 33,
                ),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: <Widget>[
                      _header(),
                      SizedBox(
                        height: 49.0,
                      ),
                      _username(),
                      SizedBox(
                        height: 20,
                      ),
                      _password(),
                      SizedBox(
                        height: 40,
                      ),
                      _loginButton(),
                      SizedBox(
                        height: 21.6,
                      ),
                      _forgotPasswordButton(),
                    ],
                  ),
                ),
              ),
              _addAnAccount(),
            ],
          ),
        ),
      ),
    );
    // ),
    // );
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

  Widget _username() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: username,
        keyboardType: TextInputType.emailAddress,
        cursorColor: white,
        decoration: InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: white)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: white)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: white),
          ),
          errorStyle: TextStyle(color: black),
          prefixIcon: Icon(
            Icons.person,
            color: white,
          ),
          hintText: 'Username',
          hintStyle: TextStyle(color: white, fontSize: 18.0),
        ),
        validator: (username) {
          if (username.isEmpty) {
            return 'Please Enter Your Username';
          } else {
            return null;
          }
        },
        onChanged: (usernam) => context.read<LoginBloc>().add(
              LoginUsernameChanged(username: usernam),
            ),
      );
    });
  }

  Widget _password() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: password,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: white,
        decoration: InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: white)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: white)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: white),
          ),
          errorStyle: TextStyle(color: black),
          prefixIcon: Icon(
            Icons.lock,
            color: white,
          ),
          // suffixIcon: IconButton(),
          hintText: 'Password',
          hintStyle: TextStyle(color: white, fontSize: 18.0),
        ),
        validator: (password) {
          if (password == "" || password.isEmpty) {
            return 'Please Enter Password';
          } else if (password.length <= 6) {
            return 'Password should be greater than 6';
          }
          return null;
        },
        onChanged: (passwd) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: passwd),
            ),
      );
    });
  }

  Widget _loginButton() {
    return BlocConsumer<LoginBloc, LoginState>(listener : (context, state){if (state is SubmissionSuccess){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Successfull'),
          ));

    }},builder: (context, state) {
      return state is FormSubmittingState
          ? CircularProgressIndicator()
          // ignore: deprecated_member_use
          : FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white)),
              height: 47.33,
              minWidth: 400.0,
              color: white,
              onPressed: () async {

                if (loginFormKey.currentState.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted(
                      username: username.text, password: password.text));

                    // print(state is SubmissionSuccess);
                  if (state.loginSubmit is SubmissionSuccess) {
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text('Login Successfull'),
                    // ));
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomePage(
                              title: 'Home Page',user: state.loginModel,
                            )));
                  }
                }

                print(username);
                print(password);
              },
              child: Text(
                "LOGIN",
                style: TextStyle(color: myRed1, fontSize: 26),
              ),
            );
    });
  }

  Widget _forgotPasswordButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      // ignore: deprecated_member_use
      return FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ForgotPage(title: "Forgot Password")));
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: white, fontSize: 18),
        ),
      );
    });
  }

  Widget _addAnAccount() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
        padding:
            EdgeInsets.only(left: 13.33, top: 210, right: 13.33, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "DON'T HAVE AN ACCOUNT?",
              style: TextStyle(
                  color: white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            FloatingActionButton(
              onPressed: () {
                if (loginFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RegisterPage(
                              title: 'Register Page',
                            )));
              },
              child: Icon(
                Icons.add,
                color: white,
                size: 30.0,
              ),
              shape: RoundedRectangleBorder(),
              backgroundColor: myRed1,
            ),
          ],
        ),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
