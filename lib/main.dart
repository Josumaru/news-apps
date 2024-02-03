import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps/config/routes/routes.dart';
import 'package:news_apps/config/theme/app_theme.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_apps/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_apps/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_apps/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const DailyNews(),
      ),
    );
  }
}