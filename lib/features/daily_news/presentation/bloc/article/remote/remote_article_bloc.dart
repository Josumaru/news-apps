
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps/core/resources/data_state.dart';
import 'package:news_apps/features/daily_news/domain/usecases/get_article_use_case.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {

  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase) : super(const RemoteArticleLoading()) {
    on <GetArticles> (onGetArticle);
  }

  void onGetArticle(GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteArticleError(dataState.error!));
    }
  }
}