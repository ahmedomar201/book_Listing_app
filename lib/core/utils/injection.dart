import 'package:book_list_app/dataLayer/networks/local/cache_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dataLayer/cubit/app_cubit.dart';
import '../../dataLayer/networks/remote/dio_helper.dart';
import '../../dataLayer/networks/repository/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc

  sl.registerFactory(() => AppBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(dioHelper: sl(), cacheHelper: sl()),
  );

  //core
  sl.registerLazySingleton<DioHelper>(() => DioImpl());
    sl.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
