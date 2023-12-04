import '../../model/Category.dart';

abstract class BaseApiService {
  Future<List<Category>> getGetApiResponse(String url);
}
