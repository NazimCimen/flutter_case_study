import 'package:case_study/config/routes/app_routes.dart';
import 'package:case_study/config/routes/navigator_service.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/core/utils/app_validators.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_state.dart';
import 'package:case_study/feature/auth/presentation/mixin/login_mixin.dart';
import 'package:case_study/feature/auth/presentation/widgets/auth_with_other_provider.dart';
import 'package:case_study/feature/auth/presentation/widgets/custom_password_text_field.dart';
import 'package:case_study/feature/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/product/widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthError) {
          return Scaffold(
            body: Center(child: Text(state.failure.errorMessage)),
          );
        }

        if (state is AuthSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.navBarView);
          });
        }

        return AbsorbPointer(
          absorbing: state is AuthLoading && state.isLoading,
          child: Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.cXLargeValue,
                          vertical: context.cMediumValue,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Login title
                              Center(
                                child: Text(
                                  StringConstants.loginTitle,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 2,
                                      ),
                                ),
                              ),

                              // Login subtitle
                              Center(
                                child: Text(
                                  StringConstants.loginSubtitle,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppColors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Email input field
                              CustomTextFormField(
                                controller: mailController,
                                validator: (value) =>
                                    AppValidators.emailValidator(value),
                                hintText: StringConstants.emailLabel,
                                prefixIconPath: ImageEnums.ic_email.toPathPng,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Password input field
                              CustomPasswordTextField(
                                controller: passwordController,
                                obsecureText: obscureText,
                                changeObsecureText: togglePasswordVisibility,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Forgot password button
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    StringConstants.forgotPassword,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ),

                              SizedBox(height: context.cLowValue),

                              // Login button
                              CustomButtonWidget(
                                onPressed: () async {
                                  await loginUser(context.read<AuthCubit>());
                                },
                                text: StringConstants.loginButton,
                                isRequestAvaliable: isRequestAvailable,
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Social media login buttons
                              AuthWithOtherProvider(
                                onGoogleTap: () async {
                                  // Google Sign In implementation
                                },
                                onAppleTap: () {
                                  // Apple Sign In implementation
                                },
                                onFacebookTap: () {
                                  // Facebook Sign In implementation
                                },
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Sign up link
                              Text.rich(
                                TextSpan(
                                  text: StringConstants.noAccount + '  ',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: StringConstants.signUpButton,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          NavigatorService.pushNamedAndRemoveUntil(
                                            AppRoutes.signupView,
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
