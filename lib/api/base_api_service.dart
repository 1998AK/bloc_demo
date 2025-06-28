import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiResponse {
  final dynamic data;        // API response data
  final String? errorMessage;       // Error message
  final bool isError;       // Error message
  final int? statusCode;     // HTTP status code

  ApiResponse({this.data, this.errorMessage, this.statusCode,this.isError = false});
}

abstract class BaseApiService {
  Future<dynamic> getApi({required String url});
  Future<dynamic> postApi({required String url, var data});
}

class NetworkServiceApi implements BaseApiService {
  final dio = Dio();

  NetworkServiceApi() {
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,     // Log request headers
        requestBody: false,      // Don't log request body
        responseBody: true,      // Log response body
        responseHeader: false,   // Don't log response headers
        error: true,
        logPrint: (log) => debugPrint("📦 DioLog: $log"),
      ));
    }
  }

  @override
  Future<ApiResponse> getApi({required String url}) async {

    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 50));

      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode,
        isError: false
      );
    } on SocketException {
      return ApiResponse(errorMessage: "No internet connection", statusCode: 0,isError: true);
    } on TimeoutException {
      return ApiResponse(errorMessage: "Time out, Try again", statusCode: 0,isError: true);
    } on DioException catch (e) {
      return ApiResponse(
        errorMessage: e.message ?? "Unknown error",
        statusCode: e.response?.statusCode ?? 0,
        isError: true
      );
    } catch (e) {
      return ApiResponse(errorMessage: "Unexpected error $e", statusCode: 0,isError: true);
    }
  }

  @override
  Future<ApiResponse> postApi({required String url, var data}) async {
    try {
      final response = await dio.post(url, data: data).timeout(const Duration(seconds: 50));
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode,
        isError: false
      );
    } on SocketException {
      return ApiResponse(errorMessage: "No internet connection", statusCode: 0,isError: true);
    } on TimeoutException {
      return ApiResponse(errorMessage: "Time out, Try again", statusCode: 0,isError: true);
    } on DioException catch (e) {
      return ApiResponse(
        errorMessage: e.message ?? "Unknown error",
        statusCode: e.response?.statusCode ?? 0,
        isError: true
      );
    } catch (e) {
      return ApiResponse(errorMessage: "Unexpected error $e", statusCode: 0,isError: true);
    }
  }
}

