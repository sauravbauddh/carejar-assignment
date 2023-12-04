import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intern_assignment/model/Category.dart';

import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<List<Category>> getGetApiResponse(String url) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      return handleResponse(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
  }


  List<Category> handleResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        if (responseBody is List) {
          // Explicitly cast to List<Map<String, dynamic>>
          final List<Map<String, dynamic>> categoryList =
          List<Map<String, dynamic>>.from(responseBody);

          // Map each item to a Category instance
          return categoryList.map((item) => Category.fromJson(item)).toList();
        } else {
          throw const FormatException("Unexpected response format");
        }      case 400:
        throw BadRequestException(responseBody['error'] ?? "Bad request");
      default:
        throw FetchDataException(
          "Error occurred with status code ${response.statusCode}: ${responseBody['message'] ?? ''}",
        );
    }
  }
}
