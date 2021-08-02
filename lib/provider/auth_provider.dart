import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent/data/models/api_response.dart';
import 'package:rent/data/models/usermodel.dart';
import 'package:rent/data/service/local_service.dart';
import 'package:rent/data/service/network_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._internal();
  static final _singleton = AuthProvider._internal();
  factory AuthProvider() => _singleton;

  final NetworkService networkService = NetworkService();
  final LocalService localService = LocalService();
  bool _islogin = false;
  bool get isLogin => _islogin;
  String _email = '';
  String get email => _email;
  int _uid = -1;
  int get uid => _uid;
  bool _isLoading = false;
  bool get isloading => _isLoading;
  Usermodel _userProfile;
  Usermodel get userProfile => _userProfile;

  Future<ApiResponse> updateProfile(
      String email, String password, String name) async {
    try {
      return networkService.updateProfile(email, password, name);
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  loadUsermodel() async {
    if (isLogin) {
      var _userdetail = await networkService.getProfile();
      _userProfile = _userdetail;
      notifyListeners();
    }
  }

  Future<void> loadAuthDetails() async {
    var _result = await localService.getLoginStatus();
    if (_result) {
      var _details = await localService.getLoginDetails();
      _islogin = true;
      _email = "${_details['email']}";
      _uid = _details['idUser'];
      loadUsermodel();
    } else {
      _islogin = false;
      _email = '';
      _uid = -1;
    }
    notifyListeners();
  }

  update() {
    notifyListeners();
  }

  Future<ApiResponse> login(String mail, String password) async {
    try {
      var _result = await networkService.login(mail, password);
      if (_result.result ?? false) {
        localService.saveLoginDetails(_result.data.email, _result.data.uid);
      }
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  Future<ApiResponse> register(
      String email, String password, String name) async {
    try {
      var _result = await networkService
          .register(Usermodel(name: name, email: email, password: password));
      if (_result.result ?? false) {
        localService.saveLoginDetails(_result.data.email, _result.data.uid);
      }
      return _result;
    } on SocketException {
      return ApiResponse(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(message: "internal error");
    }
  }

  void logout() async {
    await localService.removeLoginDetails();
    loadAuthDetails();
  }
}

