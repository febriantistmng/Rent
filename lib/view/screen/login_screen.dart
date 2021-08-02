import 'package:flutter/material.dart';
import 'package:rent/view/screen/main_screen.dart';
import 'registration_screen.dart';
import '../page/forgot_password_screen.dart';
import 'package:rent/utils/context_utils.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Incorrect email or password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Oke'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void authentication() async {
    var result = await context.autProvider
        .login(_emailController.text, _passwordController.text);
    if (result.result ?? false) {
      context.autProvider.loadAuthDetails();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      _showMyDialog();
    }
  }

  // void sendRequestGetDataUserLogin() {
  //   Userloginmodel userloginmodel = new Userloginmodel();
  //   var requestBody = jsonEncode(userloginmodel.toJson());
  //   UserLoginServices.getUserLogin(requestBody).then((value) {
  //     final result = value;
  //     if (result.success == true && result.code == 200) {
  //     } else {}
  //   }).catchError((error) {
  //     String err = error.toString();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: _emailController,
      // validator: Validator,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.blueAccent,
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.security,
          color: Colors.blueAccent,
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(12),
          ),
        ),
        child:
            Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () {
          authentication();
        },
      ),
    );

    final forgotLabel = MaterialButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.blueAccent),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return ForgotpasswordPage ();
          }),
        );
      },
    );

    // ignore: non_constant_identifier_names
    final signupLabel = MaterialButton(
      child: Text(
        "Don’t have account?, Create a new account",
        style: TextStyle(color: Colors.blueAccent),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return RegistrationPage();
          }),
        );
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 70, left: 100),
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 80.0,
                child: Image.asset(
                  'image/logo.png',
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 250),
                children: <Widget>[
                  email,
                  SizedBox(height: 24.0),
                  password,
                  SizedBox(height: 24.0),
                  loginButton,
                  signupLabel,
                  forgotLabel,
                ],
              ),
            ),
          ],
        ));
  }
}
