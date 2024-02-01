import 'package:news_apps/features/core/resources/data_state.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
