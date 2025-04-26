import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/database/expense_database.dart';
import 'package:provider/provider.dart';

import 'app/app_module.dart';
import 'app/app_page.dart';

final expenseTheme = ExpenseThemeManager(
  theme: ExpenseThemeOptions.default_theme,
);

void main() async {
  await _init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => expenseTheme),
        ChangeNotifierProvider(create: (context) => ExpenseDatabase()),
      ],
      child: ModularApp(
        module: AppModule(),
        child: const AppPage(),
      ),
    ),
  );
}

_init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await ExpenseDatabase.initialize();
}
