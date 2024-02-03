import 'package:news_apps/core/constants/constant.dart';
import 'package:news_apps/features/daily_news/data/models/article_models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('apikey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
