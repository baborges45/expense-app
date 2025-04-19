import 'package:expense_app/app/app_module.dart';
import 'package:expense_app/app/commons/commons.dart';

import 'presentation/controllers/home_controller.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/stores/home_store.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.add(HomeStore.new);
    i.add(HomeController.new);
  }

  @override
  void routes(r) {
    r.child(
      Paths.root,
      child: (context) => const HomePage(),
      transition: TransitionType.leftToRight,
    );
  }
}
