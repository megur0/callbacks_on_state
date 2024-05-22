import 'package:flutter/material.dart';

typedef CallbackOnDidUpdateWidget = void Function();
typedef CallbackOnDispose = void Function();

mixin CallbacksOnStateMethod<T extends StatefulWidget> on State<T> {
  final _callbacksOnDidUpdateWidget = <CallbackOnDidUpdateWidget>[];
  final _callbacksOnDispose = <CallbackOnDispose>[];

  void addCallbackOnDidUpdateWidget(CallbackOnDidUpdateWidget updater) {
    _callbacksOnDidUpdateWidget.add(updater);
  }

  void addCallbackOnDispose(CallbackOnDispose disposer) {
    _callbacksOnDispose.add(disposer);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as T);
    for (final callback in _callbacksOnDidUpdateWidget) {
      callback();
    }
  }

  @override
  void dispose() {
    for (final callback in _callbacksOnDispose) {
      callback();
    }
    super.dispose();
  }
}

extension UpdaterExtension on Object {
  T onDidUpdateWidget<T>(
      CallbacksOnStateMethod state, CallbackOnDidUpdateWidget updater) {
    state.addCallbackOnDidUpdateWidget(updater);
    return this as T;
  }

  T onDispose<T>(CallbacksOnStateMethod autoState, CallbackOnDispose disposer) {
    autoState.addCallbackOnDispose(disposer);
    return this as T;
  }
}
