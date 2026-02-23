import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/chart/chart_module.dart';
import 'package:expense_app/app/modules/home/home_module.dart';
import 'package:expense_app/app/modules/profile/presentation/profile_module.dart';

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
          Paths.chart,
          module: ChartModule(),
          transition: TransitionType.leftToRight,
        ),
        ModuleRoute(
          Paths.profile,
          module: ProfileModule(),
          transition: TransitionType.leftToRight,
        ),
      ],
    );
  }
}
