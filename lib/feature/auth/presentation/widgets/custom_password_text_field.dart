import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/utils/app_validators.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:case_study/product/decorations/input_decorations/custom_input_decoration.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final VoidCallback? changeObsecureText;
  final String? hintText;
  const CustomPasswordTextField({
    required this.controller,
    required this.obsecureText,
    this.changeObsecureText,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => AppValidators.passwordValidator(value),
      obscureText: obsecureText,
      textInputAction: TextInputAction.done,
      decoration: CustomInputDecoration.inputAuthDecoration(
        context: context,
        hintText: hintText ?? StringConstants.passwordLabel,
        prefixIconPath: ImageEnums.ic_password.toPathPng,
        isPassword: changeObsecureText != null,
        changeObsecureText: changeObsecureText,
        obsecureText: obsecureText,
      ),
    );
  }
}
