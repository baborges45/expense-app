import 'package:expense_app/app/commons/commons.dart';

class CarouselItemChart extends StatefulWidget {
  final List<Widget> carouselItems;
  final PageController pageController;
  final void Function() onPressed;

  const CarouselItemChart({
    super.key,
    required this.carouselItems,
    required this.pageController,
    required this.onPressed,
  });

  @override
  State<CarouselItemChart> createState() => _CarouselItemChartState();
}

class _CarouselItemChartState extends State<CarouselItemChart> with ThemeInjector {
  int _itemSDotelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: sizing.s40x,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.carouselItems.length,
            onPageChanged: (value) => setState(() => _itemSDotelected = value),
            itemBuilder: (context, index) {
              return widget.carouselItems[index];
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ExpenseButtonMini(
              label: 'Saiba mais',
              icon: ExpenseIcons.negativeFill,
              onPressed: widget.onPressed,
            ).paddingOnly(
              left: spacing.s3x,
              bottom: spacing.s3x,
            ),
            ExpenseNavControlDot(
              length: widget.carouselItems.length,
              indexSelected: _itemSDotelected,
            ).paddingOnly(
              right: spacing.s3x,
              bottom: spacing.s3x,
            ),
          ],
        ),
      ],
    );
  }
}
