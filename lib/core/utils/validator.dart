import 'package:easy_localization/easy_localization.dart';

String? nameValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'enterName'.tr();
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'onlyText'.tr();
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'enterPhone'.tr();
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'onlyNumber'.tr();
  }
  return null;
}
