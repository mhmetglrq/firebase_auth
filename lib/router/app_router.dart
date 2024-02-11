import 'package:flutter/material.dart';
import 'package:flutter_auth_app/features/auth/views/sign_up.dart';
import 'package:flutter_auth_app/features/more/view/write_article.dart';
import 'package:flutter_auth_app/features/more/view/write_code.dart';
import 'package:flutter_auth_app/models/user_model.dart';
import 'package:flutter_auth_app/router/route_names.dart';

import '../features/auth/views/sign_in.dart';
import '../features/auth/views/sign_up_info.dart';
import '../features/browse/views/article.dart';
import '../features/browse/views/code.dart';
import '../features/home/views/home.dart';
import '../features/more/view/edit_profile.dart';
import '../features/more/view/your_articles.dart';
import '../features/more/view/your_code_repos.dart';
import '../models/article_model.dart';
import '../models/code_model.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const Home());

      case AppRouteNames.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());

      case AppRouteNames.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());

      case AppRouteNames.signUpContinue:
        final arguments = settings.arguments as Map<String, dynamic>;
        final email = arguments['email'] as String;
        return MaterialPageRoute(
            builder: (_) => SignUpContinue(
                  email: email,
                ));
      case AppRouteNames.writeArticle:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
            builder: (_) => WriteArticle(
                  currentUser: currentUser,
                ));

      case AppRouteNames.writeCode:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
            builder: (_) => WriteCode(
                  currentUser: currentUser,
                ));

      case AppRouteNames.article:
        final arguments = settings.arguments as Map<String, dynamic>;
        final article = arguments['article'] as ArticleModel;
        return MaterialPageRoute(
            builder: (_) => Article(
                  article: article,
                ));

      case AppRouteNames.code:
        final arguments = settings.arguments as Map<String, dynamic>;
        final code = arguments['code'] as CodeModel;
        return MaterialPageRoute(
            builder: (_) => Code(
                  code: code,
                ));

      case AppRouteNames.editProfile:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
            builder: (_) => EditProfile(
                  currentUser: currentUser,
                ));

      case AppRouteNames.yourArticles:
        return MaterialPageRoute(builder: (_) => const YourArticles());

      case AppRouteNames.yourCodeRepos:
        return MaterialPageRoute(builder: (_) => const YourCodeRepos());

      default:
        return MaterialPageRoute(builder: (_) => const SignIn());
    }
  }
}
