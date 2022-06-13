import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  //ios
  //dio.options.baseUrl = "http://localhost:8000/api";
  //android 10.0.2.2 ip taa host machine emulator
  dio.options.baseUrl = "http://192.168.1.3:8000/api";
//ye9bel b jSon restapi
  dio.options.headers['accept'] = 'Application/Json';

  return dio;
}
