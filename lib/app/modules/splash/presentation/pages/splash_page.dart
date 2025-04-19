import 'package:flutter/material.dart';
import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/splash/presentation/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ModularInjector<SplashPage, SplashController> with ThemeInjector, TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aliasTokens.color.elements.bgColor06,
      body: Center(
        child: ExpenseSplashScreen(
          logo: Lottie.asset(
            Assets.splashscreen,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(
                  controller.loadingCompleter,
                );
            },
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
