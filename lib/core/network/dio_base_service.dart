import 'package:dio/dio.dart';
class DioBaseService {
  Dio dio = Dio();

  DioBaseService() {
    configureDio();
  }

  void configureDio() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      contentType: 'application/json; charset=UTF-8'
    );
    dio = Dio(options);
  }
}
