import 'package:expense_app/app/app_module.dart';
import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/chart/presentation/controllers/chart_controller.dart';
import 'package:expense_app/app/modules/chart/presentation/pages/chart_page.dart';
import 'package:expense_app/app/modules/chart/presentation/store/chart_store.dart';

class ChartModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton(ChartStore.new);
    i.addSingleton(ChartController.new);
  }

  @override
  void routes(r) {
    r.child(
      Paths.root,
      child: (context) => const ChartPage(),
      transition: TransitionType.leftToRight,
    );
  }
}
