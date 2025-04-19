import 'dart:developer';

import 'package:expense_app/app/commons/commons.dart';

abstract class ModularInjector<T extends StatefulWidget, C extends PageLifeCycleController> extends State<T> {
  late C controller;

  @override
  @mustCallSuper
  void initState() {
    controller = Modular.get<C>();
    controller.store.messageStream.listen(
      (message) {
        if (mounted) {
          ExpenseToastColoful.show(
            context: context,
            message: message,
            type: controller.store.hasError ? ExpenseToastType.negative : ExpenseToastType.positive,
          );
        }
      },
    );
    log('${controller.runtimeType} initialized', name: 'Modular injector');
    controller.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log('${controller.runtimeType} ready', name: 'Modular injector');
      controller.onReady();
    });
    super.initState();
  }

  @override
  @mustCallSuper
  void dispose() {
    controller.onClose();
    Modular.dispose<C>();
    log('${controller.runtimeType} disposed', name: 'Modular injector');
    super.dispose();
  }
}
