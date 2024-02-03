import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_apps/features/daily_news/domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final void Function(ArticleEntity articleEntity)? onRemove;
  final void Function(ArticleEntity articleEntity)? onArticPressed;

  const ArticleTile(
      {Key? key,
      this.article,
      this.onArticPressed,
      this.onRemove,
      this.isRemovable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 14,
          end: 14,
          bottom: 7,
          top: 7,
        ),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(context),
            _buildRemovableArea(),
          ],
        ),
      ),
    );
  }

  _onTap() {
    if (onArticPressed != null) {
      onArticPressed!(article!);
    }
    ;
  }

  _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article!.urlToImage!,
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 14,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
            ),
            child: const CupertinoActivityIndicator(),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
            ),
            child: const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  _buildTitleAndDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              article!.title!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            Text(
              article!.description!,
              maxLines: 2,
              style: const TextStyle(color: Colors.black54),
            ),
            Row(
              children: [
                const Icon(
                  Icons.timeline_outlined,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  article!.publishedAt ?? '',
                  style: const TextStyle(color: Colors.black54),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildRemovableArea() {
    if (isRemovable!) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Icon(Ionicons.remove_circle),
      );
    }
    return Container();
  }
  _onRemove() {
    if (onRemove != null) {
      onRemove!(article!);
    }
  }
}
