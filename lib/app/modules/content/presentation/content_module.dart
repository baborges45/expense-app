import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/home/home_module.dart';

import 'content_page.dart';

class ContentModule extends Module {
  @override
  void routes(r) {
    r.child(
      Paths.root,
      child: (context) => const ContentPage(),
      transition: TransitionType.leftToRight,
      children: [
        ModuleRoute(
          Paths.home,
          module: HomeModule(),
          transition: TransitionType.leftToRight,
        ),
        ModuleRoute(
          Paths.profile,
          module: HomeModule(),
          transition: TransitionType.leftToRight,
        ),
        ModuleRoute(
          Paths.community,
          module: HomeModule(),
          transition: TransitionType.leftToRight,
        ),
      ],
    );
  }
}
