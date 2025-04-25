import 'package:movieapp/core/check_network_wrapper/check_network_wrapper.dart';

import 'dio_instance.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class DioClient {
  // dio instance
  final DioInstance _dioInstance;

  // injecting dio instance
  DioClient(this._dioInstance);

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      bool result = await CheckNetworkWrapper.isInternetWorking();

      if (result == false) {
        throw Exception("No Internet Connection.");
      }
      final Response response = await _dioInstance.dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      // LogManager.printf(e.toString());
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      bool result = await CheckNetworkWrapper.isInternetWorking();

      if (result == false) {
        var r = Response(
          requestOptions: RequestOptions(path: uri),
          statusCode: 503,
          data: "No Internet Connection",
          statusMessage: "No Internet Connection",
        );
        throw DioException(
          response: r,
          requestOptions: RequestOptions(path: ""),
          error: "No Internet Connection",
        );
      }
      final Response response = await _dioInstance.dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    } finally {}
  }
}
