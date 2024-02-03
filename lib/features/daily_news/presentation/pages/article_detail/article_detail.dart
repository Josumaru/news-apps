import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_apps/injection_container.dart';

class ArticleDetail extends HookWidget {
  final ArticleEntity article;
  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBakButtonTapped(context),
          child: const Icon(Ionicons.chevron_back),
        ),
      ),
    );
  }

  void _onBakButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleContent(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article!.title!,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.timeline),
              const SizedBox(width: 5),
              Text(
                article.publishedAt.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Ionicons.person_outline,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                article?.author ?? 'Anonymous',
                style: const TextStyle(
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return CachedNetworkImage(
      imageUrl: article.urlToImage!,
    );
  }

  Widget _buildArticleContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 10,
      ),
      child: Text(
        article.content!,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        backgroundColor: Colors.amber,
        elevation: 0,
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Ionicons.bookmark_outline),
      );
    });
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.black54,
      content: Text('Article Added to bookmark!'),
    ));
  }
}
