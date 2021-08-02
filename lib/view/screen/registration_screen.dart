import 'package:flutter/material.dart';
import 'package:rent/utils/context_utils.dart';
import 'package:rent/view/screen/login_screen.dart';

class RegistrationPage extends StatefulWidget {
  static String tag = 'registration-page';
  @override
  _RegistrationPageState createState() => new _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void sentRequestInsertDataUser() async {
    var name = _nameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      context.showSnacbar("please fill all fields");
    } else {
      var result = await context.autProvider.register(email, password, name);
      context.showSnacbar(result.message ?? "cannot process your request");
      if (result.result ?? false) {
        context.pushTo(LoginPage());
      }
    }
  }

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Full Name',
        prefixIcon: Icon(
          Icons.perm_identity_sharp,
          color: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      obscureText: !_showPassword,
      validator: (value) {
        if (value.isEmpty) {
          return 'Password Field must not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.security,
          color: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglevisibility();
          },
          child: Container(
            height: 50,
            width: 70,
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Center(
              child: Text(
                _showPassword ? "Hide" : "Show",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );

    final validasipassword = TextFormField(
      autofocus: false,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      obscureText: !_showPassword,
      validator: (value) {
        if (value.isEmpty) {
          return 'Password Field must not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        prefixIcon: Icon(
          Icons.security,
          color: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglevisibility();
          },
          child: Container(
            height: 50,
            width: 70,
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Center(
              child: Text(
                _showPassword ? "Hide" : "Show",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          sentRequestInsertDataUser();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child: Text('Create Account',
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
    );

    // ignore: non_constant_identifier_names

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 80),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 90.0,
                child: Image.asset(
                  'image/splash.png',
                  height: 300,
                  width: 600,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 120,
                  right: 80,
                  top: 170,
                ),
                child: Text(
                  'SignUp Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
              child: ListView(
                key: _formkey,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 200),
                children: <Widget>[
                  name,
                  SizedBox(height: 15.0),
                  email,
                  SizedBox(height: 15.0),
                  password,
                  SizedBox(height: 15.0),
                  validasipassword,
                  SizedBox(height: 20.0),
                  loginButton,
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 130,
                right: 100,
                top: 620,
              ),
              child: Text('or connect with'),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 660),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('image/facebook.png'),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('image/google.png'),
                      ),
                    ),
                    Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('image/twitter.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
