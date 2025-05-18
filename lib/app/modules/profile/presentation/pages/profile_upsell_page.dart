import 'package:expense_app/app/commons/commons.dart';
import 'package:flutter/material.dart';

class ProfileUpSell extends StatefulWidget {
  const ProfileUpSell({super.key});

  @override
  State<ProfileUpSell> createState() => _ProfileUpSellState();
}

class _ProfileUpSellState extends State<ProfileUpSell> with ThemeInjector, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ExpenseImage.asset(Assets.loginBackground),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: aliasTokens.color.elements.bgColor01.withValues(
                alpha: aliasTokens.color.disabled.opacity,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: globalTokens.shapes.size.s11x,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ExpenseBrand(
                        type: ExpenseBrandType.logo,
                      ),
                      Row(
                        children: [
                          ExpenseButtonIcon(
                            icon: ExpenseIcons.settings,
                            onPressed: () {},
                          ),
                          ExpenseButtonIcon(
                            icon: ExpenseIcons.closeLine,
                            onPressed: Modular.to.pop,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const ExpenseHeading(
                  'Continue e aproveite',
                  size: ExpenseHeadingSize.xl,
                ),
                SizedBox(
                  height: spacing.s5x,
                ),
                ExpenseButtonGroup(
                  buttonPrimary: ExpenseButton(
                    label: 'Cadastro',
                    onPressed: () => _navigateAndWait(Routes.signUp),
                    type: ExpenseButtonType.blocked,
                  ),
                  buttonTertiary: ExpenseButtonMini(
                    label: 'Já tenho conta?',
                    onPressed: () => _navigateAndWait(Routes.signIn),
                  ),
                ),
                SizedBox(
                  height: spacing.s2x,
                ),
                SizedBox(
                  height: spacing.s2_5x,
                ),
              ],
            ).symmetricPadding(horizontal: spacing.s3x),
          )
        ],
      ),
    );
  }

  void _navigateAndWait(String route) async {
    await Modular.to.pushNamed(route);
    if (Modular.get<AppStore>().authenticated) {
      Modular.to.pop();
    }
  }
}
