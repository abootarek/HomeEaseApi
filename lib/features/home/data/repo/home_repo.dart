import 'dart:developer';

import 'package:home_ease/core/networking/remote/api_error_handler.dart';
import 'package:home_ease/core/networking/remote/api_result.dart';
import 'package:home_ease/core/networking/remote/api_service.dart';
import 'package:home_ease/features/categorie/data/models/category_model.dart';

class HomeRepo{
   final ApiService _apiService;
  HomeRepo(this._apiService);
  Future<ApiResult<CategoryModel>> getCategories(
   ) async {
    try {
      final response = await _apiService.getCategories();
      log(response.toString());
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}