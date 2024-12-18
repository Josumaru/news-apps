import 'package:get_it/get_it.dart';
import 'package:news_apps/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_apps/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_apps/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_apps/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_apps/features/daily_news/domain/usecases/get_article_use_case.dart';
import 'package:news_apps/features/daily_news/domain/usecases/get_saved_article_use_case.dart';
import 'package:news_apps/features/daily_news/domain/usecases/remove_article_use_case.dart';
import 'package:news_apps/features/daily_news/domain/usecases/save_article_use_case.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void>initializeDependencies() async {

  // Database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // DIO
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl(), sl())
  );

  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl())
  );

  sl.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(sl())
  );

  // sl.registerSingleton<GetArticleUseCase>(
  //   GetArticleUseCase(sl())
  // );

  sl.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(sl())
  );

  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(sl())
  );

  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(sl())
  );

  sl.registerFactory<LocalArticleBloc>(
    () => LocalArticleBloc(sl(), sl(), sl())
  );
}
