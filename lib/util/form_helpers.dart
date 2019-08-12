import 'package:flutter/material.dart';

class FormHelper {
  static Map<T, FocusNode> generateFocusNodeMap<T>(List<T> values) {
    final _result = Map<T, FocusNode>();
    for (T item in values) {
      _result[item] = FocusNode();
    }
    return _result;
  }

  static Map<T, TextEditingController> generateTextControllerMap<T>(
      List<T> values) {
    final _result = Map<T, TextEditingController>();
    for (T item in values) {
      _result[item] = TextEditingController();
    }
    return _result;
  }

  static Map<T, GlobalKey<FormFieldState>> generateFormFieldKeyMap<T>(
      List<T> values) {
    final _result = Map<T, GlobalKey<FormFieldState>>();
    for (T item in values) {
      _result[item] = GlobalKey<FormFieldState>();
    }
    return _result;
  }

  static Map<T, bool> generateAutoValidateMap<T>(List<T> values) {
    final _result = Map<T, bool>();
    for (T item in values) {
      _result[item] = false;
    }
    return _result;
  }

  static void disposeFocusNodes(Map<dynamic, FocusNode> focusNodes) {
    focusNodes.forEach((key, focusNode) {
      focusNode.dispose();
    });
  }

  static void disposeTextControllers(
      Map<dynamic, TextEditingController> textControllers) {
    textControllers.forEach((key, textController) {
      textController.dispose();
    });
  }
}
