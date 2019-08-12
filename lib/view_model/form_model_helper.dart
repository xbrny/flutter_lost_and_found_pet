import 'dart:async';

mixin FormModelHelper {
  final _errorController = StreamController<String>.broadcast();
  Stream<String> get error$ => _errorController.stream;
  Sink<String> get inError => _errorController.sink;

  final _successController = StreamController<bool>.broadcast();
  Stream<bool> get success$ => _successController.stream;
  Sink<bool> get inSuccess => _successController.sink;

  disposeFormStateHelper() {
    _errorController.close();
    _successController.close();
  }
}
