import 'dart:io';

import 'package:news_apps/features/core/constants/constant.dart';
import 'package:news_apps/features/core/resources/data_state.dart';
import 'package:news_apps/features/daily_news/data/data_sources/news_api_service.dart';
import 'package:news_apps/features/daily_news/data/models/article_models.dart';
import 'package:news_apps/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: newsApiKey,
          category: newsCategoryQuery,
          country: newsCountryQuery);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions)
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
