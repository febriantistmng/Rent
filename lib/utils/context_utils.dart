import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/provider/auth_provider.dart';
import 'package:rent/provider/main_provider.dart';
import 'package:rent/provider/payment_provider.dart';

extension ContextUtils on BuildContext {
  PaymentProvider _getPaymentProvider() =>
      Provider.of<PaymentProvider>(this, listen: false);
  MainProvider _getMainProvider() =>
      Provider.of<MainProvider>(this, listen: false);
  AuthProvider _getAuthProvider() =>
      Provider.of<AuthProvider>(this, listen: false);
  MediaQueryData _getMediaQuery() => MediaQuery.of(this);
  MediaQueryData get mediaQueryData => _getMediaQuery();
  showSnacbar(String msg) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg ?? "",
              ),
            ],
          ),
        ),
      );
  pushTo(Widget to) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (ctx) => to));

  replaceTo(Widget to) => Navigator.of(this)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => to));

  MainProvider get mainProvider => _getMainProvider();
  AuthProvider get autProvider => _getAuthProvider();
  PaymentProvider get paymentProvider => _getPaymentProvider();
}
