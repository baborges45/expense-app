import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/profile/presentation/profile_store.dart';

class ProfileController extends PageLifeCycleController {
  @override
  final ProfileStore store;
  final AppStore appStore;

  final LocalRepository localStorage;
  final ApiRepository repository;

  ProfileController({
    required this.appStore,
    required this.store,
    required this.localStorage,
    required this.repository,
  });

  @override
  void onInit() {
    super.onInit();
    store.completed();
    if (!appStore.authenticated) {
      navigateToNonLoginProfile();
    }
  }

  void navigateToNonLoginProfile() async {
    await Modular.to.pushNamed(
      Routes.profileUpsell,
    );
    if (!appStore.authenticated) {
      Modular.to.navigate(
        Routes.home,
      );
    }
  }

  void signOut() {
    appStore.user = null;
    Modular.get<HttpAdapter>().setAuthorizationToken(null);
    Modular.to.pop();
    Modular.to.navigate(Routes.home);
  }
}
