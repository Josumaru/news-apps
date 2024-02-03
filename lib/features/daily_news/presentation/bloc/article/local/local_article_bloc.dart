import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps/features/daily_news/domain/usecases/get_saved_article_use_case.dart';
import 'package:news_apps/features/daily_news/domain/usecases/remove_article_use_case.dart';
import 'package:news_apps/features/daily_news/domain/usecases/save_article_use_case.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._removeArticleUseCase,
    this._saveArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticle> (onGetSavedArticle);
    on<RemoveArticle> (onRemoveArticle);
    on<SaveArticle> (onSaveArticle);
  }

  void onGetSavedArticle(GetSavedArticle event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final article = await _getSavedArticleUseCase();
    emit(LocalArticleDone(article));
  }

  void onSaveArticle(SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final article = await _getSavedArticleUseCase();
    emit(LocalArticleDone(article));
  }
}
