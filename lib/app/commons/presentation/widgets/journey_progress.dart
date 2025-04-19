import 'package:expense_app/app/commons/commons.dart';

class JourneyProgress extends StatelessWidget with ThemeInjector {
  const JourneyProgress({
    super.key,
    required this.progress,
  });
  final int progress;

  @override
  Widget build(BuildContext context) {
    return ExpenseProgressCircular(
      progress: progress,
      size: ExpenseProgressCircularSize.xs,
    );
  }
}
