import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/Category.dart';
import '../repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository authRepo = AuthRepository();

  Future<List<Category>> categoryApi(BuildContext context) async {
    final List<Category> localCategories = await getCategoriesFromLocal();

    if (localCategories.isNotEmpty) {
      return localCategories;
    }

    try {
      final List<Category> categories = await authRepo.getCategoryApi();
      await saveCategoriesToLocal(categories);
      return categories;
    } catch (error) {
      print('Error fetching categories: $error');
      throw error;
    }
  }

  Future<void> saveCategoriesToLocal(List<Category> categories) async {
    await Hive.initFlutter();
    final box = await Hive.openBox('categories_box');

    await box.clear();

    categories.forEach((category) {
      box.add(category);
    });
  }

  Future<List<Category>> getCategoriesFromLocal() async {
    await Hive.initFlutter();
    final box = await Hive.openBox('categories_box');

    final List<Category> localCategories = box.values.toList().cast<Category>();
    return localCategories;
  }
}
