import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rent/data/models/book.dart';
import 'package:rent/data/models/products.dart';
import 'package:rent/data/service/network_service.dart';
import 'package:rent/view/page/BookCar.dart';
import 'package:rent/view/page/dialog_loading_progress.dart';
import 'package:rent/view/page/payment_page.dart';
import 'package:rent/utils/context_utils.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentProvider._internal();
  static final _singleton = PaymentProvider._internal();
  factory PaymentProvider() => _singleton;
  NetworkService _networkService = NetworkService();
  BuildContext _context;
  bool _isPaymentActive = false;
  Product _currentProduct;
  Product get currentProduct => _currentProduct;
  PaymentType _type = PaymentType.MBANKING;
  PaymentType get type => _type;
  bool get isPaymentActive => _isPaymentActive;
  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;
  // PaymentType
  int _duration = 1;
  int get duration => _duration;
  DateTime get endDate => _getEndDate();

  int get totalPayment => _duration * _currentProduct.price;
  setType(PaymentType newType) {
    _type = newType;
    notifyListeners();
  }

  setStart(DateTime newDate) {
    _startDate = newDate;
    notifyListeners();
  }

  setDuration(int newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  pay(Product product) async {
    if (!_isPaymentActive) {
      _isPaymentActive = true;
      _currentProduct = product;
      BookCarPage.skey.currentState.showBottomSheet(
        (BuildContext context) {
          _context = context;
          return Container(
              height: _context.mediaQueryData.size.height * 0.6,
              child: PaymentPage());
        },
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
      ).closed
        ..then((value) {
          _isPaymentActive = false;
          notifyListeners();
        });
      notifyListeners();
    } else {
      if (_context != null) {
        Dialogs.showLoadingDialog(_context, BookCarPage.skey);
        try {
          // var tfee = range * (int.tryParse(fields.pricePerHour ?? "1") ?? 1);
          var book = Book(
            idProduct: _currentProduct.idProducts,
            date: DateTime.now(),
            rentStart: _startDate,
            rentEnd: _getEndDate(),
            totalFee: totalPayment.toString(),
            paymentType: _type,
            notes: "booked",
          );

          var res = await _networkService.makeOrder(book);
          _context.showSnacbar(res.message ?? "internal error");
          Dialogs.hideLoadingDialog(BookCarPage.skey);
          if (res.result ?? false) {
            _context.mainProvider.loadHistoryBook();
            Timer(
                Duration(milliseconds: 200),
                () =>
                    Navigator.of(_context).popUntil((route) => route.isFirst));
          }
        } catch (e) {
          Dialogs.hideLoadingDialog(BookCarPage.skey);
          debugPrint(e.toString());
        }
      }
    }
  }

  DateTime _getEndDate() {
    switch (_currentProduct.rentalType) {
      case RentalType.monthly:
        return _startDate.add(Duration(days: (_duration * 30)));
        break;
      case RentalType.weekly:
        return _startDate.add(Duration(days: (_duration * 7)));

        break;
      case RentalType.daily:
        return _startDate.add(Duration(days: _duration));

        break;
    }
    return _startDate.add(Duration(days: _duration));
  }
}
