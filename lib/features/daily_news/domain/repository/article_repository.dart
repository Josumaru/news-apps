import 'package:news_apps/core/resources/data_state.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // API
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  // Database
  Future<List<ArticleEntity>> getSavedArticle();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);

}
