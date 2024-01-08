import 'package:flutter_auth_app/features/more/repository/more_repository.dart';
import 'package:flutter_auth_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/article_model.dart';

final moreControllerProvider = Provider((ref) {
  final moreRepository = ref.watch(moreRepositoryProvider);
  return MoreController(moreRepository: moreRepository);
});

class MoreController {
  final MoreRepository moreRepository;

  MoreController({required this.moreRepository});

  Future<void> signOut() async {
    await moreRepository.signOut();
  }

  Future<void> writeArticle(ArticleModel model) async {
    await moreRepository.writeArticle(model);
  }

  Stream<List<ArticleModel>> getArticles() {
    return moreRepository.getArticles();
  }

  Future<UserModel> getUser() async {
    return await moreRepository.getUser();
  }
}
