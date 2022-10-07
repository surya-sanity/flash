import 'package:flash/services/databaseservice.dart';
import 'package:flash/services/services.dart';
import 'package:flash/viewmodels/auth_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'viewmodels/viewmodels.dart';

final locator = GetIt.instance;

setup() {
  locator.registerLazySingleton<Authviewmodel>(() => Authviewmodel());
  locator.registerLazySingleton<StorageViewModel>(() => StorageViewModel());
  locator.registerLazySingleton<ChatUserListViewModel>(
      () => ChatUserListViewModel());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
}
