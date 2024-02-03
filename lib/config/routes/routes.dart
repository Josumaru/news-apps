import 'package:flutter/material.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';
import 'package:news_apps/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_apps/features/daily_news/presentation/pages/article_saved/article_saved.dart';
import 'package:news_apps/features/daily_news/presentation/pages/home/daily_news.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return _materialRoute(const DailyNews());
      case '/ArticleDetail':
        return _materialRoute(ArticleDetail(article: routeSettings.arguments as ArticleEntity,));
      case '/ArticleSaved':
        return _materialRoute(const ArticleSaved());
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
