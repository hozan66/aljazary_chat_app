import '../../network/local/cache_helper.dart';

const double myDefaultPadding = 20.0;

String? token;

final String userEmail = CacheHelper.getData(key: 'userEmail') ?? 'userEmail';
