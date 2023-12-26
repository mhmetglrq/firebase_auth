import 'package:flutter_auth_app/features/browse/repository/browse_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/article_model.dart';

final browseControllerProvider = Provider((ref) => BrowseController(
      browseRepository: ref.watch(browseRepositoryProvider),
    ));

class BrowseController {
  final BrowseRepository browseRepository;
  BrowseController({required this.browseRepository});

  Stream<List<ArticleModel>> getArticles() {
    return browseRepository.getArticles();
  }
}
