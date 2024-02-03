import 'package:equatable/equatable.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';

abstract class LocalArticleState extends Equatable{
  final List<ArticleEntity> ? article;

  const LocalArticleState({this.article});

  @override
  List<Object> get props => [article!];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> article) : super(article: article);
}