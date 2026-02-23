import 'package:flutter/material.dart';
import 'package:expense_app/app/commons/commons.dart';
import 'package:provider/provider.dart';

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

    return Consumer<ExpenseThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp.router(
          theme: _buildThemeData(themeManager, ExpenseThemeMode.light),
          darkTheme: _buildThemeData(themeManager, ExpenseThemeMode.dark),
          themeMode: themeManager.modeSelected == ExpenseThemeMode.light
              ? ThemeMode.light
              : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          title: 'Expense',
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }

  ThemeData _buildThemeData(
    ExpenseThemeManager themeManager,
    ExpenseThemeMode mode,
  ) {
    final themeModel = listThemes.singleWhere(
      (t) => t.theme == themeManager.themeSelected,
    );
    final alias = mode == ExpenseThemeMode.light
        ? themeModel.aliasLight
        : themeModel.aliasDark;

    // Map tokens to ColorScheme - using basic mappings
    final colorScheme = ColorScheme(
      brightness: mode == ExpenseThemeMode.light
          ? Brightness.light
          : Brightness.dark,
      primary: alias.color.action.bgPrimaryColor,
      onPrimary: alias.color.action.onLabelPrimaryColor,
      secondary: alias.color.promote.bgColor,
      onSecondary: alias.color.promote.onLabelColor,
      error: alias.color.negative.bgColor,
      onError: alias.color.negative.onLabelColor,
      surface: alias.color.surface.color02,
      onSurface: alias.color.text.labelColor,
    );

    return ThemeData(colorScheme: colorScheme, useMaterial3: true);
  }

  void _debugRoute() {
    debugPrint('Navigate: ${Modular.to.path}');
    // FirebaseAnalytics.instance.logScreenView(
    //   screenName: Modular.to.path,
    // );
    debugPrint('History: ${Modular.to.navigateHistory.map((e) => e.name)}');
  }
}
