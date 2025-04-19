import 'package:flutter/material.dart';
import 'package:expense_app/app/commons/commons.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  initState() {
    super.initState();
    Modular.to.addListener(_debugRoute);
  }

  @override
  void dispose() {
    Modular.to.removeListener(_debugRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.splash);

    return MaterialApp.router(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Expense',
      routerConfig: Modular.routerConfig,
    );
  }

  void _debugRoute() {
    debugPrint('Navigate: ${Modular.to.path}');
    // FirebaseAnalytics.instance.logScreenView(
    //   screenName: Modular.to.path,
    // );
    debugPrint('History: ${Modular.to.navigateHistory.map((e) => e.name)}');
  }
}
