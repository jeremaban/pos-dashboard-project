import 'package:dio/dio.dart';
import 'dart:convert';

class ApiClient {
  final Dio _dio;

  ApiClient({required String baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await _dio.get(uri, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      print("GET request failed on api_client.dart: ${e.type} - ${e.message}");
      if (e.response != null) {
        return e.response!;
      } else {
        return Response(
          requestOptions: RequestOptions(path: uri),
          statusCode: 500,
          statusMessage: "Connection error: ${e.message}",
        );
      }
    } catch (e) {
      print("Unexpected error on api_client.dart: $e");
      return Response(
        requestOptions: RequestOptions(path: uri),
        statusCode: 500,
        statusMessage: "Unexpected error occurred",
      );
    }
  }

  Future<Response> postData(
    String uri,
    Map<String, dynamic> data, {
    String? authToken,
  }) async {
    try {
      print("Attempting POST form data to: $uri");
      print("With data: $data");

      _dio.options.contentType = Headers.jsonContentType;

      //FOR TOKEN
      if (authToken != null && authToken.isNotEmpty) {
        _dio.options.headers['Authorization'] = 'Bearer $authToken';
      }

      Response response = await _dio.post(uri, data: jsonEncode(data));

      print("Response received: ${response.statusCode}");

      print("Response data: ${jsonEncode(response.data)}");
      return response;
    } on DioException catch (e) {
      print("POST request failed on api_client.dart: ${e.type} - ${e.message}");
      print("Request data was: ${e.requestOptions.data}");
      if (e.response != null) {
        return e.response!;
      } else {
        return Response(
          requestOptions: RequestOptions(path: uri),
          statusCode: 500,
          statusMessage: "Connection error: ${e.message}",
        );
      }
    } catch (e) {
      print("Unexpected error: $e");
      return Response(
        requestOptions: RequestOptions(path: uri),
        statusCode: 500,
        statusMessage: "Unexpected error occurred",
      );
    }
  }
}
