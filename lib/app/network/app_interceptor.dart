import 'package:dio/dio.dart';
import 'package:tasky/app/caching/shared_prefs.dart';

import 'end_points.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors({
    required this.dio,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    String? authToken = Caching.get(key: "access_token");
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      String? accessToken = Caching.get(key: "access_token");
      String? refreshToken = Caching.get(key: "refresh_token");

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await dio.get(ApiConstants.refreshTokenUrl,
            queryParameters: {'token': refreshToken}).then(
          (value) {
            String accessToken = value.data["access_token"];
            Caching.put(key: "access_token", value: accessToken);
          },
        );
        accessToken = Caching.get(key: "access_token");
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
    }
    super.onError(err, handler);
  }
}
