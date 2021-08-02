import 'package:flutter/material.dart';
import 'package:rent/data/service/network_service.dart';
import 'package:rent/utils/context_utils.dart';
import 'package:rent/view/screen/login_screen.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key key, this.email}) : super(key: key);
  final String email;
  final TextEditingController _codeEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reset your password"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 70.0,
                  child: Image.asset(
                    'image/logo.png',
                    width: 220,
                    height: 90,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _codeEditingController,
                    decoration: InputDecoration(labelText: "verification code"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "new password",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (_codeEditingController.text.isNotEmpty &&
                          _passwordEditingController.text.isNotEmpty &&
                          _passwordEditingController.text.length > 5) {
                        var res = await NetworkService().resetPassword(
                          email,
                          _codeEditingController.text,
                          _passwordEditingController.text,
                        );
                        context.showSnacbar(res.message);
                        if (res.result ?? false) {
                          context.replaceTo(
                            LoginPage(),
                          );
                        }
                      } else {
                        context.showSnacbar("password length must greater 5");
                      }
                    },
                    child: Text("submit"),
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
