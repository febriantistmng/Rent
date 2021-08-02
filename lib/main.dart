import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/provider/auth_provider.dart';
import 'package:rent/provider/main_provider.dart';
import 'package:rent/provider/payment_provider.dart';
import 'package:rent/view/screen/splash_screen.dart';
//import 'package:rent/service/auth_services.dart';

void main() => runApp(new Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => MainProvider()),
        ChangeNotifierProvider(create: (ctx) => PaymentProvider()),
      ],
      child: MaterialApp(
        //value: AuthServices.firebaseUserStream,
        //child: MaterialAp
        debugShowCheckedModeBanner: false,
        title: 'SplasScreen',
        theme: ThemeData(),
        home: SplashScreen(),
      ),
    );
  }
}
