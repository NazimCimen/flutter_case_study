import 'package:case_study/feature/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:case_study/feature/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';

mixin LoginMixin on State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _mailController;
  late final TextEditingController _passwordController;
  bool isRequestAvailable = false;
  bool isGoogleLoading = false;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool _obscureText = true;

  TextEditingController get mailController => _mailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get formKey => _formKey;
  bool get obscureText => _obscureText;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Attempts to log in user with email and password.
  /// Returns true if login is successful, false otherwise.
  Future<void> loginUser(AuthCubit authCubit) async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    validateFields();
    if (isRequestAvailable) {
      await authCubit.login(
        email: _mailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  /// Validates form fields and updates request availability status.
  void validateFields() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isRequestAvailable = true;
      });
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
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
