import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({'appid':'37ea9939152496e5de6ca532f93817fd'});
    handler.next(options);
  }
}