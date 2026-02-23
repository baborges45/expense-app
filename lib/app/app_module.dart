import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/commons/data/repositories/local/local_repository_impl.dart';
import 'package:expense_app/app/commons/data/repositories/remote/remote_repository_impl.dart';
import 'package:expense_app/app/modules/profile/presentation/pages/profile_upsell_page.dart';

import 'modules/content/presentation/content_module.dart';
import 'modules/splash/presentation/splash_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton(AppStore.new);
    i.addSingleton(() => GetStorage());
    i.addSingleton<LocalRepository>(LocalRepositoryImpl.new);
    i.addSingleton<HttpAdapter>(DioDatasource.new);
    i.addSingleton<ApiRepository>(ApiRepositoryImpl.new);
  }

  @override
  void routes(r) {
    r.module(
      Paths.splash,
      module: SplashModule(),
    );
    r.module(
      Paths.content,
      module: ContentModule(),
    );
    r.child(
      Paths.profileUpsell,
      child: (context) => const ProfileUpSell(),
      transition: TransitionType.downToUp,
    );
    // r.module(
    //   Paths.signIn,
    //   module: SignInModule(),
    //   transition: TransitionType.downToUp,
    // );
    // r.module(
    //   Paths.signUp,
    //   module: SignUpModule(),
    //   transition: TransitionType.downToUp,
    // );
  }
}
