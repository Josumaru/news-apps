import 'package:floor/floor.dart';
import 'package:news_apps/core/constants/constant.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publisedAt,
    String? content,
  }) : super(
            id: id,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publisedAt,
            content: content);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] != '' && json['urlToImage'] != null
          ? json['urlToImage']
          : kDefaultImage,
      publisedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      id: entity.id,
      title: entity.title,
      url: entity.url,
      urlToImage: entity.urlToImage,
      author: entity.author,
      publisedAt: entity.publishedAt,
      description: entity.content,
      content: entity.content,
    );
  }
}
