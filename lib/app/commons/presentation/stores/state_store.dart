import 'dart:async';

import 'package:expense_app/app/commons/commons.dart';

abstract class StateStore {
  final Rx<StateStoreStatus> _status = Rx<StateStoreStatus>(StateStoreStatus.loading);

  StateStoreStatus get status => _status.value;
  Rx<StateStoreStatus> get rxStatus => _status;

  final StreamController<String> _messageStream = StreamController.broadcast();

  Stream<String> get messageStream => _messageStream.stream;

  set status(StateStoreStatus value) => _status.value = value;
  set error(String? value) {
    _status.value = StateStoreStatus.error;
    if (value != null) {
      _messageStream.sink.add(value);
    }
  }

  void completed([String? value]) {
    _status.value = StateStoreStatus.completed;
    if (value != null) {
      _messageStream.sink.add(value);
    }
  }

  void loading() => _status.value = StateStoreStatus.loading;
  void noContent() => _status.value = StateStoreStatus.noContent;

  bool get isLoading => status == StateStoreStatus.loading;
  bool get hasError => status == StateStoreStatus.error;
  bool get isCompleted => status == StateStoreStatus.completed;
}
