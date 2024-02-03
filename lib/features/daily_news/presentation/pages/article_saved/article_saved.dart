import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_apps/features/daily_news/presentation/wigdets/article_tile.dart';
import 'package:news_apps/injection_container.dart';

class ArticleSaved extends HookWidget {
  const ArticleSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticle()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar();
  }

  _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticleLoading) {
          return const CupertinoActivityIndicator();
        } else if (state is LocalArticleDone) {
          return _buildArticleList(state.article!);
        }
        return Container();
      },
    );
  }

  _buildArticleList(List<ArticleEntity> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleTile(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(context, article),
          onArticPressed: (articleEntity) => _onArticlePressed(context, articleEntity),
        );
      },
    );
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
  }
  void _onArticlePressed(BuildContext context, ArticleEntity articleEntity) {
    print('object');
    Navigator.pushNamed(context, '/ArticleDetail',arguments: articleEntity);
  }
}
