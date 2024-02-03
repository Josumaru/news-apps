import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_apps/features/daily_news/presentation/wigdets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}

_buildAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      'Daily News',
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      GestureDetector(
        onTap: () => _onShowSavedArticlesViewTapped(context),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Icon(Ionicons.bookmark),
        ),
      ),
    ],
  );
}

_buildBody() {
  return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
    if (state is RemoteArticleLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is RemoteArticleError) {
      return const Center(child: Icon(Icons.refresh));
    }
    if (state is RemoteArticleDone) {
      return ListView.builder(
        itemCount: state.articles!.length,
        itemBuilder: (context, index) {
          return ArticleTile(
            article: state.articles![index],
            onArticPressed: (article) => _onArticlePressed(context, article),
          );
        },
      );
    }
    return const SizedBox();
  });
}

void _onArticlePressed(BuildContext context, ArticleEntity articleEntity) {
  Navigator.pushNamed(context, '/ArticleDetail', arguments: articleEntity);
}

void _onShowSavedArticlesViewTapped(BuildContext context) { 
  Navigator.pushNamed(context, '/ArticleSaved');
}