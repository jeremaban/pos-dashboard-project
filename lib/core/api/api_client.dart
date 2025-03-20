import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {"Content-Type": "application/json"},
        ));

  Future<Response> getData(String uri) async {
    try {
      Response response = await _dio.get(uri);
      return response;
    } catch (e) {
      print("GET request failed: $e");
      return Response(
        requestOptions: RequestOptions(path: uri),
        statusCode: 500,
        statusMessage: "Internal Server Error",
      );
    }
  }

  Future<Response> postData(String uri, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(uri, data: data);
      return response;
    } catch (e) {
      print("POST request failed: $e");
      return Response(
        requestOptions: RequestOptions(path: uri),
        statusCode: 500,
        statusMessage: "Internal Server Error",
      );
    }
  }
}
