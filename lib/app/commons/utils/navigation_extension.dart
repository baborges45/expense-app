import 'package:expense_app/app/commons/commons.dart';

extension NagivationExtensions on IModularNavigator {
  bool hasRoute(String route) => navigateHistory.any(
        (h) => h.name.startsWith(route),
      );
}
