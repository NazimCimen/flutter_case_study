import 'dart:async';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:case_study/feature/auth/presentation/view/sign_up_view.dart';
import 'package:case_study/product/componets/custom_snack_bars.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/material.dart';

mixin SignupMixin on State<SignUpView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameSurnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool isRequestAvailable = false;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool _obscureText = true;
  bool _isTermsAgreed = true;

  TextEditingController get nameSurnameController => _nameSurnameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  GlobalKey<FormState> get formKey => _formKey;
  bool get obscureText => _obscureText;
  bool get isTermsAgreed => _isTermsAgreed;

  @override
  void initState() {
    _nameSurnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameSurnameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Creates a new user account with provided credentials.
  /// Returns true if signup is successful, false otherwise.
  Future<void> signupUser(AuthCubit authCubit) async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    // validate fields
    validateFields();
    // if fields are valid and terms are agreed, signup
    if (isRequestAvailable && isTermsAgreed) {
      await authCubit.signup(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameSurnameController.text.trim(),
      );
    }
  }

  /// Handles terms and conditions checkbox state changes.
  void onTermsCheckboxChanged(bool? value) {
    setState(() {
      _isTermsAgreed = value ?? false;
    });
  }

  /// Validates form fields and terms agreement.
  /// Updates request availability and shows appropriate messages.
  void validateFields() {
    if (formKey.currentState!.validate() && isTermsAgreed) {
      setState(() {
        isRequestAvailable = true;
      });
    } else if (!isTermsAgreed) {
      CustomSnackBars.showCustomBottomScaffoldSnackBar(
        context: context,
        text: StringConstants.pleaseAcceptTerms,
      );
      setState(() {
        isRequestAvailable = false;
      });
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
        isRequestAvailable = false;
      });
    }
  }

  /// Toggles password visibility in the password field.
  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /// Sets request availability to false and updates UI state.
  void makeRequestUnavailable() {
    setState(() {
      isRequestAvailable = false;
    });
  }
}
