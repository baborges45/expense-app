import 'package:expense_app/app/commons/commons.dart';

class StateObserver extends StatelessWidget {
  const StateObserver({
    super.key,
    required this.state,
    required this.onCompleted,
    required this.onLoading,
    required this.onError,
    this.noContent,
  });

  final StateStoreStatus state;
  final WidgetBuilder onCompleted;
  final WidgetBuilder onLoading;
  final WidgetBuilder? noContent;
  final WidgetBuilder onError;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case StateStoreStatus.loading:
        return onLoading(context);
      case StateStoreStatus.noContent:
        return noContent?.call(context) ?? const SizedBox.shrink();
      case StateStoreStatus.error:
        return onError(context);
      case StateStoreStatus.completed:
        return onCompleted(context);
    }
  }
}
