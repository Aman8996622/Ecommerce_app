import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInstance {
  Dio dio;
  DioInstance(this.dio) {
    var options = BaseOptions(
      baseUrl: "https://api.themoviedb.org/3/",
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds

      receiveDataWhenStatusError: true,
      followRedirects: false,
      contentType: "application/json",
    );
    dio = Dio(options);
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: false,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        compact: true,
        error: true,
        maxWidth: 90,
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        String? errorMessage;
        if (error.response != null) {
          switch (error.response?.statusCode) {
            case 302:
              errorMessage = 'Something went wrong. Please try again.';
              break;
            case 400:
              errorMessage = 'Bad Request';
              break;
            case 401:
              errorMessage = 'Unauthorized';
              break;
            case 403:
              errorMessage =
                  'Your session has expired. Please log in again to continue';

              break;
            case 404:
              errorMessage = 'Not Found';
              break;
            case 500:
              errorMessage =
                  'Oops! Something went wrong on our end. Our developers have been notified and are working on a fix. We apologize for the inconvenience and appreciate your patience';

              break;
            default:
              errorMessage = error.message;
              break;
          }
        } else {
          errorMessage = 'Something went wrong. Please try again later.';
        }

        var errorrr = DioException(
            requestOptions: error.requestOptions, error: errorMessage);
        handler.reject(errorrr);
      },
    ));
  }
}
