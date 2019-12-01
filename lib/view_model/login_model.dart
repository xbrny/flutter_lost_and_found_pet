import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';
import 'package:lost_found_pet_prototype/service_locator.dart';
import 'package:lost_found_pet_prototype/view_model/form_model_helper.dart';

class LoginModel extends ChangeNotifier with FormModelHelper {
  final AbstractUserApi userApi = locator<AbstractUserApi>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'bani@email.com');
  final passwordController = TextEditingController(text: 'bani1234');

  bool isSubmitting = false;

  submitButtonPressed() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    isSubmitting = true;
    notifyListeners();

    try {
      await userApi.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      inSuccess.add(true);
    } catch (e) {
      print(e);
      inError.add(e.message);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeFormStateHelper();
    emailController.dispose();
    passwordController.dispose();
  }
}
