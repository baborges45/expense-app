import 'package:flutter/material.dart';
import 'package:expense_app/app/commons/commons.dart';

class HomeLoading extends StatelessWidget with ThemeInjector {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aliasTokens.color.elements.bgColor01,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 27,
              ),
              ExpenseSkeleton(
                height: sizing.s30x,
                width: double.infinity,
              ),
              SizedBox(
                height: spacing.s5x,
              ),
              Row(
                children: [
                  ExpenseSkeleton(
                    height: sizing.s4x,
                    width: 147,
                  ),
                  const Spacer(),
                  ExpenseSkeleton(
                    height: sizing.s6x,
                    width: sizing.s25x,
                    borderRadius: BorderRadius.circular(
                      globalTokens.shapes.border.radiusCircular,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: spacing.s4x,
              ),
              Column(
                spacing: spacing.s2x,
                children: List.generate(8, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: spacing.s1x),
                    child: ExpenseSkeleton(
                      height: sizing.s7x,
                      width: double.infinity,
                    ),
                  );
                }),
              ),
              SizedBox(
                height: spacing.s15x,
              ),
            ],
          ).paddingSymmetric(horizontal: spacing.s3x),
        ),
      ),
    );
  }
}
