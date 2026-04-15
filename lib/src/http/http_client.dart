import 'package:dio/dio.dart';

class HttpClient {
  late Dio dio;

  HttpClient() {
    dio = Dio(BaseOptions(

      baseUrl: 'https://viacep.com.br/ws/', 
      connectTimeout: 5000,
      receiveTimeout: 3000,

      responseType: ResponseType.json,
    ));
  }
}