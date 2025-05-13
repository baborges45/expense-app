import 'package:expense_app/app/app_module.dart';
import 'package:expense_app/app/commons/commons.dart';

import 'controllers/profile_controller.dart';
import 'pages/profile_page.dart';
import 'profile_store.dart';

class ProfileModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton(ProfileStore.new);
    i.addSingleton(ProfileController.new);
  }

  @override
  void routes(r) {
    r.child(
      Paths.root,
      child: (context) => const ProfilePage(),
      transition: TransitionType.rightToLeft,
    );
  }
}
