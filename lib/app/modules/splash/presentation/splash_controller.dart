import 'dart:async';

import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/splash/presentation/splash_store.dart';

class SplashController extends PageLifeCycleController {
  final ApiRepository repository;
  final LocalRepository localStorage;
  @override
  final SplashStore store;
  final AppStore appStore;

  SplashController({
    required this.store,
    required this.repository,
    required this.localStorage,
    required this.appStore,
  });

  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  void loadingCompleter() async {
    if (store.isLoading) {
      store.completed();
    } else {
      Modular.to.pushReplacementNamed(Routes.home);
    }
  }

  void _startTimer() async {
    Future.delayed(2.seconds).then((_) => loadingCompleter());
  }
}
