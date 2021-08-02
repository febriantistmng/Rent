import 'package:flutter/material.dart';
import 'package:rent/data/service/network_service.dart';
import 'package:rent/view/page/reset_password_screen.dart';
import '../screen/login_screen.dart';
import 'package:rent/utils/context_utils.dart';

class ForgotpasswordPage extends StatefulWidget {
  static String tag = 'ForgotPassword-page';
  @override
  _ForgotpasswordPageState createState() => new _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: _editingController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.blueAccent,
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final nextButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text("send verification code"),
        onPressed: () async {
          if (_editingController.text.contains('@') &&
              _editingController.text.contains('.')) {
            var res = await NetworkService().sendVerificationCode(
              _editingController.text,
            );
            context.showSnacbar(res.message);
            if (res.result ?? false) {
              context.replaceTo(
                ResetPassword(
                  email: _editingController.text,
                ),
              );
            }
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.blueAccent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: 70, left: 110),
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 70.0,
              child: Image.asset(
                'image/logo.png',
                width: 220,
                height: 90,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250, left: 150),
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 25.0,
              child: Icon(
                Icons.lock_rounded,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 330, left: 30),
              child: Text(
                "We will send you an email with instruction ",
                style: TextStyle(fontSize: 16),
              )),
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 400),
              children: <Widget>[
                email,
                SizedBox(height: 15.0),
                nextButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
