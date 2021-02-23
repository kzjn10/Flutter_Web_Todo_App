import 'package:get_it/get_it.dart';

import '../module/bloc_module.dart';
import '../module/local_datasource_module.dart';
import '../module/repository_module.dart';

GetIt injector = GetIt.instance;

class Injection {
  static Future setUpLocator() async {
    await LocalDatasourceModule().provides();
    await RepositoryModule().provides();
    await BlocModule().provides();
  }
}
