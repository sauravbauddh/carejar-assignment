


import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../model/Category.dart';
import '../res/url_endpoints.dart';

class AuthRepository {
  BaseApiService baseApiService = NetworkApiService();



  Future<List<Category>> getCategoryApi() async {
    try {
      Future<List<Category>> response =
      baseApiService.getGetApiResponse(UrlEndpoints.categoryUrl );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
