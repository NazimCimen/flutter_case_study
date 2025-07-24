import 'package:case_study/config/routes/app_routes.dart';
import 'package:case_study/config/routes/navigator_service.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/core/utils/app_validators.dart';
import 'package:case_study/feature/auth/presentation/mixin/sign_up_mixin.dart';
import 'package:case_study/feature/auth/presentation/widgets/auth_with_other_provider.dart';
import 'package:case_study/feature/auth/presentation/widgets/custom_password_text_field.dart';
import 'package:case_study/feature/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:case_study/product/componets/custom_snack_bars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_state.dart';
import 'package:case_study/product/widgets/custom_button.dart';
part '../widgets/toggle_terms.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with SignupMixin {
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
                              // Header section with title and subtitle
                              Text(
                                textAlign: TextAlign.center,
                                StringConstants.signUpTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      height: 2,
                                    ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                StringConstants.signUpSubtitle,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),

                              SizedBox(height: context.cXLargeValue * 1.2),

                              // Name and surname input field
                              CustomTextFormField(
                                controller: nameSurnameController,
                                validator: (value) =>
                                    AppValidators.nameSurnameValidator(value),
                                hintText: StringConstants.nameLabel,
                                prefixIconPath:
                                    ImageEnums.ic_nameSurname.toPathPng,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Email input field
                              CustomTextFormField(
                                controller: emailController,
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

                              // Confirm password input field
                              CustomPasswordTextField(
                                controller: passwordController,
                                obsecureText: obscureText,
                                changeObsecureText: togglePasswordVisibility,
                                hintText: StringConstants.confirmPasswordLabel,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Terms and conditions toggle
                              const _ToggleTerms(),

                              SizedBox(height: context.cXLargeValue * 1.2),

                              // Sign up button
                              CustomButtonWidget(
                                onPressed: () async {
                                  await signupUser(context.read<AuthCubit>());
                                },
                                text: StringConstants.signUpButton,
                                isRequestAvaliable: isRequestAvailable,
                              ),

                              SizedBox(height: context.cLargeValue * 1.2),

                              // Social authentication buttons
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

                              SizedBox(height: context.cXLargeValue),

                              // Login link for existing users
                              Text.rich(
                                TextSpan(
                                  text:
                                      StringConstants.alreadyHaveAccount + '  ',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: '${StringConstants.loginButton}!',
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
                                            AppRoutes.loginView,
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
