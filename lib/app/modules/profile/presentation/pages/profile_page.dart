import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/commons/utils/helpers.dart';
import 'package:expense_app/app/modules/profile/presentation/controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularInjector<ProfilePage, ProfileController> with ThemeInjector {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = controller.appStore.user;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: globalTokens.shapes.size.s11x,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExpenseButtonIcon(icon: ExpenseIcons.settings, onPressed: () {}),
                  ],
                ),
              ),
              if (!isNullOrEmpty(user?.name)) ...[
                ExpenseHeading(
                  controller.appStore.user?.name ?? '',
                  size: ExpenseHeadingSize.xl,
                ),
              ],
              SizedBox(
                height: spacing.s15x,
              ),
            ],
          ).paddingOnly(
            top: spacing.s5x,
            bottom: spacing.s2_5x,
            left: spacing.s3x,
            right: spacing.s3x,
          ),
        );
      },
    );
  }

  Widget get _buildEmptyState {
    return ExpenseCardContainer(
      fixedSize: false,
      child: SizedBox(
        height: 144,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseIcon(icon: ExpenseIcons.informationLine),
            SizedBox(
              height: spacing.s2_5x,
            ),
            const Expanded(
              child: Text("You haven't started your journey yet. Let us help you find the perfect one to begin!"),
            ),
            ExpenseButtonMini(
              label: 'Find new Journeys',
              onPressed: () => Modular.to.navigate(
                Routes.home,
              ),
              icon: ExpenseIcons.navigationRightLine,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required Widget child,
  }) {
    return Column(
      children: [
        SizedBox(
          height: spacing.s5x,
        ),
        ExpenseDivider.thin(),
        SizedBox(
          height: spacing.s5x,
        ),
        child,
      ],
    );
  }
}
