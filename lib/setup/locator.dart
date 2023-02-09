import 'package:get_it/get_it.dart';

import '../service/persistence_service.dart';
import '../service/auth_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerSingletonAsync<PersistenceService>(
      () async => PersistenceService.init());

  serviceLocator.registerSingletonWithDependencies<AuthService>(
      () => AuthService(),
      dependsOn: [PersistenceService]);
}
