import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Rreset_Password/Reset_Password_Bloc.dart';
import 'package:neo_store/Bloc/Rreset_Password/Reset_Password_Event.dart';
import 'package:neo_store/Bloc/Rreset_Password/Reset_Password_State.dart';
import 'package:neo_store/Colors/color.dart';
import 'package:neo_store/Repository/Reset_Password_Repo.dart';
import 'package:neo_store/model/Register_model.dart';
import 'My_account_page.dart';

class ResetPage extends StatefulWidget {
  ResetPage({Key key, this.title, this.user}) : super(key: key);

  RegisterResponseModel user;

  final String title;

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: myRed1,
      body: BlocProvider<ResetPasswordBloc>(
        create: (context) => ResetPasswordBloc(
          ResetPasswordAuthRepo: context.read<ResetPasswordRepo>(),
        ),
        child: _form(),
      ),
    );
  }

  Widget _form() {
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
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'NeoSTORE',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w700,
                          color: white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 49.0,
                    ),
                    _currentPass(),
                    SizedBox(
                      height: 13.0,
                    ),
                    _newPass(),
                    SizedBox(
                      height: 13.0,
                    ),
                    _confirmPass(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // ignore: deprecated_member_use
                    _resetButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: myRed1,
      title: Text(
        'Reset Password',
        style: TextStyle(fontSize: 25.0, color: white),
      ),
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

  Widget _currentPass() {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
      return TextFormField(
        controller: currentPass,
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
          prefixIcon: Icon(
            Icons.lock,
            color: white,
          ),
          hintText: 'Current Password',
          hintStyle: TextStyle(color: white, fontSize: 18.0),
        ),
        onChanged: (value) => context
            .read<ResetPasswordBloc>()
            .add(OnCurrentPasswordChanged(currentPassword: value)),
      );
    });
  }

  Widget _newPass() {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
      return TextFormField(
        controller: newPass,
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
          prefixIcon: Icon(
            Icons.lock,
            color: white,
          ),
          hintText: 'New Password',
          hintStyle: TextStyle(color: white, fontSize: 18.0),
        ),
        onChanged: (value) => context
            .read<ResetPasswordBloc>()
            .add(OnNewPasswordChanged(newPassword: value)),
      );
    });
  }

  Widget _confirmPass() {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
      return TextFormField(
        controller: confirmPass,
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
          prefixIcon: Icon(
            Icons.lock,
            color: white,
          ),
          hintText: 'Confirm Password',
          hintStyle: TextStyle(color: white, fontSize: 18.0),
        ),
        onChanged: (value) => context
            .read<ResetPasswordBloc>()
            .add(OnConfirmNewPasswordChanged(confirmNewPassword: value)),
      );
    });
  }

  Widget _resetButton() {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.white)),
        height: 47.33,
        minWidth: 400.0,
        color: white,
        onPressed: () async {
          print(currentPass);
          print('${widget.user.data.accessToken}');
          context.read<ResetPasswordBloc>().add(ResetSubmitted(
              accessToken: '${widget.user.data.accessToken}',
              currentPassword: currentPass.text,
              newPassword: newPass.text,
              confirmNewPassword: confirmPass.text));

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MyAccountPage(
                        title: 'Login Page',
                        user: widget.user,
                      )));
        },
        child: Text(
          "Reset Password",
          style: TextStyle(color: myRed1, fontSize: 26),
        ),
      );
    });
  }
}
