import 'package:ecommerce_app/common/models/ValidatedTextField.dart';
import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:ecommerce_app/others/back/sign_pages/sign_in/SignInPageCubit.dart';
import 'package:ecommerce_app/others/sign_pages/widgets/SocialSignButtons.dart';
import 'package:ecommerce_app/others/widgets_folder/AppBar1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/theme/ThemeUtils.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  //-------------------------------------------------------------------------- main
  @override
  Widget build(BuildContext context) {
    AppConstants.setDeviceSize(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSizes.appBarHeight()),
          child: AppBar1(isSignPage: true),
        ),
        body: const SafeArea(
          child: Center(
            child: SingleChildScrollView(reverse: true, child: _FormContent()),
          ),
        ),
      ),
    );
  }
}

class _FormContent extends StatelessWidget {
  // ignore: unused_element_parameter
  const _FormContent({super.key});

  //-------------------------------------------------------------------------- Form
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInPageCubit>();
    final tr = AppLocalizations.of(context)!;
    AppConstants.setDeviceSize(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppSizes.signInPageFrameWidth(),
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizes.verticalSpaceMedium().height!),
                  //-------------------------------------------------------------------------- title
                  Center(
                    child: Text(
                      tr.titleWelcome,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  AppSizes.verticalSpaceMedium(),

                  //-------------------------------------------------------------------------- lottie emoji
                  Container(
                    color: ThemeUtils.transparent,
                    width: AppSizes.animationWidthWidthLarge(),
                    height: AppSizes.animationWidthWidthLarge(),
                    child: Lottie.asset(
                      'lib/core/assets/animations/Animation1.json',
                      repeat: true,
                    ),
                  ),

                  AppSizes.verticalSpaceMedium(),

                  //-------------------------------------------------------------------------- Email Part
                  SizedBox(
                    width: 1.sw,
                    child: ValidatedTextField(
                      label: tr.labelEmail,
                      icon: Icons.email,
                      controller: cubit.emailController,
                      validator: (value) {
                        AutovalidateMode.onUserInteraction;
                        if (value == null || value.isEmpty)
                          return TextFeildValidationMessage.feildRequired.name;
                        if (!value.contains('@'))
                          return TextFeildValidationMessage.emailError.name;
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  AppSizes.verticalSpaceMedium(),

                  //-------------------------------------------------------------------------- Password Part
                  SizedBox(
                    width: 1.sw,
                    child: Column(
                      children: [
                        ValidatedTextField(
                          label: tr.labelPassword,
                          icon: Icons.lock,
                          controller: cubit.passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return TextFeildValidationMessage
                                  .feildRequired
                                  .name;
                            if (value.length < 6)
                              return TextFeildValidationMessage
                                  .lengthError
                                  .name;
                            return null;
                          },
                          obscureText: true,
                        ),

                        AppSizes.verticalSpaceMedium(),

                        //-------------------------------------------------------------------------- Forgot Password Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.push(AppRoutes.forgetPassword);
                            },
                            child: Text(
                              tr.buttonForgetPassword,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                        AppSizes.verticalSpaceMedium(),

                        //-------------------------------------------------------------------------- Sign In Button
                        BlocConsumer<SignInPageCubit, SignInPageState>(
                          listener: (context, state) {
                            if (state is SignInError) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(tr.messageProblem),
                                  content: Text(
                                    AppConstants.translateValidationMessage(
                                      context,
                                      state.message,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => context.pop(),
                                      child: Text(tr.generalOk),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is SignInSuccess) {
                              context.push(AppRoutes.bottomNavBar);
                            }
                          },
                          builder: (context, state) {
                            if (state is SignInLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => cubit.signIn(),
                                child: Text(tr.generalSignIn),
                              ),
                            );
                          },
                        ),
                        AppSizes.verticalSpaceMedium(),
                        //-------------------------------------------------------------------------- don't have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                tr.textDontHaveAccount,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  context.push(AppRoutes.signUp);
                                },
                                child: Text(
                                  tr.generalSignUp,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //-------------------------------------------------------------------------- social buttons
                        const SocialSignButtons(),
                        AppSizes.verticalSpaceMedium(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
