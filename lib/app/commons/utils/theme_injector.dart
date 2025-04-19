import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/main.dart';

mixin ThemeInjector {
  ExpenseThemeManager get _tokens => expenseTheme;
  GlobalBase get globalTokens => _tokens.globals;
  AliasBase get aliasTokens => _tokens.alias;

  GlobalShapesSpacingBase get spacing => globalTokens.shapes.spacing;
  GlobalShapesSizeBase get sizing => globalTokens.shapes.size;
}

extension ThemeRecovery on BuildContext {
  ExpenseThemeManager get tokens => expenseTheme;
  GlobalBase get globalTokens => tokens.globals;
  AliasBase get aliasTokens => tokens.alias;
}
