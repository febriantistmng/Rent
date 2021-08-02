import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/provider/auth_provider.dart';
import 'package:rent/view/page/showroom.dart';
import 'package:rent/view/screen/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, _) => value.isLogin ? Showroom() : LoginPage(),
    );
  }
}
