import 'package:flutter/material.dart';
import 'package:rent/data/models/api_response.dart';
import 'package:rent/data/models/book.dart';
import 'package:rent/data/models/products.dart';
import 'package:rent/data/service/network_service.dart';

class MainProvider extends ChangeNotifier {
  MainProvider._internal();
  static final _singleton = MainProvider._internal();
  factory MainProvider() => _singleton;

  final NetworkService networkService = NetworkService();
  List<Book> _historyBook = [];
  List<Book> get historyBook => _historyBook;
  List<Product> _products = [];
  List<Product> get products => _products;
  loadAllData() async {
    await loadHistoryBook();
    await loadProducts();
  }

  Future loadHistoryBook() async {
    var result = await networkService.getHistoryBooking();
    result.sort((a, b) => b.date.compareTo(a.date));
    _historyBook = result;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    var itemList = await networkService.getProducts();
    _products = itemList;
    notifyListeners();
  }

  Future<ApiResponse> makeOrder(Book book) async {
    try {
      return await networkService.makeOrder(book);
    } catch (e) {
      debugPrint(e.toString());
    }
    return ApiResponse(message: "cannot process your request, try later");
  }
}
