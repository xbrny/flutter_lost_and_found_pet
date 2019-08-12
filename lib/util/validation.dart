import 'package:email_validator/email_validator.dart';

class Validator {
  static String validateEmail(String value) {
    if (!EmailValidator.validate(value)) {
      return 'The email address is badly formatted.';
    }
    return null;
  }

  static String validatePassword(String value) {
    final notEmptyError = validateNotEmpty(value);

    if (notEmptyError != null) {
      return notEmptyError;
    }

    if (value.length < 6) {
      return 'This field must be at least 6 characters.';
    }
    return null;
  }

  static String validateNotEmpty(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  static String validateDateTime(DateTime value) {
    if (value == null) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  static String validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return null;
    }

    if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(value)) {
      return 'This field must be a valid phone number.';
    }

    return null;
  }
}
