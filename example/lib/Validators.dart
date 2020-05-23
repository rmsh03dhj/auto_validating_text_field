import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator required(
      {String errorText = "This field cannot be empty."}) {
    return (value) {
      if (value == null ||
          ((value is Iterable || value is String || value is Map) &&
              value.length == 0)) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator validLength(int length,
      {String errorText = "Invalid phone number"}) {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value.length != length) {
          return errorText;
        }
      }
      return null;
    };
  }

  static FormFieldValidator pattern(
    Pattern pattern, {
    String errorText = "Value does not match pattern.",
  }) {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (!RegExp(pattern).hasMatch(value)) return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator matches(TextEditingController controller, {
    String errorText = "Confirm Password doesn't match.",
  }) {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (controller.text.compareTo(value.toString()) != 0) return errorText;
      }
      return null;
    };
  }
}
