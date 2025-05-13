import 'package:flutter/material.dart';
import 'package:expense_app/app/commons/commons.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> with ThemeInjector {
  final List<String> _tabRoutes = [
    Routes.home,
    Routes.chart,
    Routes.profile,
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Modular.to.addListener(_checkIndexForRoute);
  }

  void _checkIndexForRoute() {
    final path = Modular.to.path;
    final index = _tabRoutes.indexWhere((route) => path.startsWith(route));
    if (index != _currentIndex && index != -1) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  void dispose() {
    Modular.to.removeListener(_checkIndexForRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aliasTokens.color.elements.bgColor01,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExpenseBottomBarFloat(
        width: sizing.s35x,
        items: [
          ExpenseBottomBarFloatItem(
            label: 'Home',
            icon: ExpenseIcons.homeLine,
          ),
          ExpenseBottomBarFloatItem(
            label: 'Histórico',
            icon: ExpenseIcons.statistic,
          ),
          ExpenseBottomBarFloatItem(
            label: 'Profile',
            icon: ExpenseIcons.profile,
          ),
        ],
        onChanged: (index) {
          Modular.to.navigate(_tabRoutes[index]);
        },
        currentIndex: _currentIndex,
      ),
      body: const RouterOutlet(),
    );
  }
}
