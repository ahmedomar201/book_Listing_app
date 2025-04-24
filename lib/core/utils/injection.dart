
import 'package:get_it/get_it.dart';

import '../../dataLayer/cubit/app_cubit.dart';
import '../../dataLayer/networks/remote/dio_helper.dart';
import '../../dataLayer/networks/repository/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc

  sl.registerFactory(
    () => AppBloc(
      repository: sl(),
    ),
  );


  // Repository
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
    ),
  );

//core
    sl.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

}
