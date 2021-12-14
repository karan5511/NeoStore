import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_store/Bloc/Forgot_Password/ForgotPasswordRepo.dart';
import 'package:neo_store/Repository/Add_Address_Repo.dart';
import 'package:neo_store/Repository/Edit_Account_repo.dart';
import 'package:neo_store/Repository/Fetch_Account_repo.dart';
import 'package:neo_store/Repository/HomeAuthenticationRepo.dart';
import 'package:neo_store/Repository/OrderDetailsRepo.dart';
import 'package:neo_store/Repository/Product_Detail_Repo.dart';
import 'package:neo_store/Repository/Reset_Password_Repo.dart';
import 'package:neo_store/Repository/add_to_cart.dart';
import 'package:neo_store/Repository/cart_repo.dart';
import 'package:neo_store/Repository/loginAuthenticationRepo.dart';
import 'package:neo_store/Repository/orders_repo.dart';
import 'package:neo_store/Screens/Reset_password.dart';
import 'package:neo_store/model/Product_Details_model.dart';
import 'package:neo_store/model/cart_list_model.dart';

import 'Repository/RegisterAuthenticationRepo.dart';

import 'Screens/Forgot_Password_Page.dart';
import 'Screens/Home_Page.dart';
import 'Screens/Login_Page.dart';
import 'Screens/Product_Details.dart';

void main() {
  runApp(MyApp());
  // runApp(BlocProvider(create: (context) => RegisterBloc(RegisterInitial())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers:[
          RepositoryProvider<LoginAuthRepository>(
              create: (context) => LoginAuthRepository()),
          RepositoryProvider<RegisterAuthRepository>(
              create: (context) => RegisterAuthRepository()),
          RepositoryProvider<ForgotPasswordAuthRepository>(
              create: (context)=> ForgotPasswordAuthRepository()),
          RepositoryProvider<HomeAuthRepo>(
              create: (context)=> HomeAuthRepo()),
          RepositoryProvider<AddToCartRepo>(
              create: (context) => AddToCartRepo()),
          RepositoryProvider<AccDetailsRepo>(
              create: (context) => AccDetailsRepo()),
          RepositoryProvider<EditAccRepo>(
              create: (context) => EditAccRepo()),
          RepositoryProvider<ResetPasswordRepo>(
              create: (context) => ResetPasswordRepo()),
          RepositoryProvider<CartAuthRepository>(
              create: (context) => CartAuthRepository()),
          RepositoryProvider<AddressAuthRepository>(
              create: (context) => AddressAuthRepository()),
          RepositoryProvider<OrderListRepo>(
              create: (context) => OrderListRepo()),
          RepositoryProvider<OrderDetailsRepository>(
              create: (context) => OrderDetailsRepository()),

        ],

    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Neostore App ',
        theme: ThemeData(
          fontFamily: 'Gotham',
          primarySwatch: Colors.blue,
        ),
        home:LoginPage
        (

              ),

    ),
        );
  }
}
