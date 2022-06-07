import 'dart:developer';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gest_event_slama_best_choice_app/models/user.dart';
import 'package:flutter_gest_event_slama_best_choice_app/services/dio.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  User _user = User(name: '', email: '', avatar: '');
  String _token = '';
  bool get authentiated => _isLoggedIn;
  User get user => _user;
  //nhathro instance mil local storage bch nstoriw fiha l token bc kkol mara mayo93edch lutilastaeur yconicti ki yokhrej mil app
  final storage = new FlutterSecureStorage();

  void login({required Map creds}) async {
    //print creds just for test
    print(creds);

    try {
      //tpingi lapi taana w bl creds nistanaw response
      Dio.Response response = await dio().post('/sanctum/token', data: creds);
      print(response.data.toString());

      String token = response.data.toString();
      //tjareb token li jak mil api
      this.tryToken(token: token);

      // _isLoggedIn = true;

      // notifyListeners();

    } catch (e) {
      print(e);
    }
  }

  String getToken() {
    return this._token;
  }

  void tryToken({String? token}) async {
    //kan token null tredirectih
    if (token == null) {
      return;
    } else {
      try {
        //tjib data aaal user
        Dio.Response response = await dio().get('/user',
            //taatih type auto token
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        //cbn taabi taatih l'ok bch yconicti kano cbn connecter
        this._isLoggedIn = true;
        //taabi l model
        this._user = User.fromJson(response.data);
        //taabi token
        this._token = token;
        //tw nstoriw token taana fil local storage taa tel
        this.storeToken(token: token);
        notifyListeners();
        print(_user);
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken({required String token}) async {
    //naamlo store l token bil key value
    this.storage.write(key: 'token', value: token);
  }

  void logout() async {
    try {
      //tpingi api bch yfasekhlik all keys token mil BDD
      Dio.Response response = await dio().get('/user/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
      //baed maytest ili header token shih yfasakhdenya lkol reset hata mil key yafasakhhom taa token user
      cleanUp();
      notifyListeners();
    } catch (e) {
      //snn print err
      print(e);
    }
  }

  void cleanUp() async {
    var __token = '';
    this._user = User(name: '', email: '', avatar: '');
    this._isLoggedIn = false;
    this._token = __token;
    await storage.delete(key: 'token');
  }
}
