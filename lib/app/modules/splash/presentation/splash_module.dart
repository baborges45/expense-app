import 'package:expense_app/app/app_module.dart';
import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:expense_app/app/modules/splash/presentation/splash_controller.dart';
import 'package:expense_app/app/modules/splash/presentation/splash_store.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.add(SplashStore.new);
    i.add(SplashController.new);
  }

  @override
  void routes(r) {
    r.child(
      Paths.root,
      child: (context) => const SplashPage(),
    );
  }
}
