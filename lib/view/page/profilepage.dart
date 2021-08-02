import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/provider/auth_provider.dart';
import 'package:rent/utils/context_utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListView(
        children: [
          Consumer<AuthProvider>(
            builder: (context, value, child) => Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 40, bottom: 40),
                    child: Column(
                      children: <Widget>[
                        // Fullname
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Full Name    : ' +
                                  (value.userProfile.name ?? "no name"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Email
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email            : ' + (value.email),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password    : ' +
                                  (value.userProfile.password ?? "*********"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  width: 450,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.autProvider.logout();
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(5),
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
