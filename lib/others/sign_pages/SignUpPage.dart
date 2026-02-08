import 'package:ecommerce_app/common/models/ValidatedTextField.dart';
import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:ecommerce_app/others/back/sign_pages/sign_out/SignUpPageCubit.dart';
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

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.setDeviceSize(context);
    //-------------------------------------------------------------------------- main
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
    final cubit = context.read<SignUpPageCubit>();
    final tr = AppLocalizations.of(context)!;
    AppConstants.setDeviceSize(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),
          SizedBox(
            width: AppSizes.signInPageFrameWidth(),
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //-------------------------------------------------------------------------- title
                  Center(
                    child: Text(
                      tr.titleCreateAccount,
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
                      'lib/core/assets/animations/Animation3.json',
                      repeat: true,
                    ),
                  ),

                  AppSizes.verticalSpaceMedium(),

                  //-------------------------------------------------------------------------- Name Part
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 1.sw,
                      child: Row(
                        children: [
                          Expanded(
                            child: ValidatedTextField(
                              label: tr.labelFirstName,
                              icon: Icons.person,
                              controller: cubit.firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return TextFeildValidationMessage
                                      .feildRequired
                                      .name;
                                if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value))
                                  return TextFeildValidationMessage
                                      .nameContentError
                                      .name;
                                if (value.length < 2)
                                  return TextFeildValidationMessage
                                      .lengthError
                                      .name;
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(width: AppSizes.paddingSmall() * 3),
                          Expanded(
                            child: ValidatedTextField(
                              label: tr.labelLastName,
                              icon: Icons.person,
                              controller: cubit.lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return TextFeildValidationMessage
                                      .feildRequired
                                      .name;
                                if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value))
                                  return TextFeildValidationMessage
                                      .nameContentError
                                      .name;
                                if (value.length < 2)
                                  return TextFeildValidationMessage
                                      .lengthError
                                      .name;
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSizes.verticalSpaceMedium(),

                  //-------------------------------------------------------------------------- Email Part
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 1.sw,
                      child: ValidatedTextField(
                        label: tr.labelEmail,
                        icon: Icons.email,
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return TextFeildValidationMessage
                                .feildRequired
                                .name;
                          if (!value.contains('@'))
                            return TextFeildValidationMessage.emailError.name;
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  AppSizes.verticalSpaceMedium(),

                  //-------------------------------------------------------------------------- Password Part
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
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
                          //-------------------------------------------------------------------------- Confirm Password
                          ValidatedTextField(
                            label: tr.labelConfirmPassword,
                            icon: Icons.lock,
                            controller: cubit.confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return TextFeildValidationMessage
                                    .feildRequired
                                    .name;
                              if (value.trim() !=
                                  cubit.passwordController.text.trim())
                                return TextFeildValidationMessage
                                    .confirmPasswordError
                                    .name;
                              return null;
                            },
                            obscureText: true,
                          ),
                          SizedBox(
                            height: AppSizes.verticalSpaceMedium().height! + 35,
                          ),
                          //-------------------------------------------------------------------------- Sign Up Button
                          BlocConsumer<SignUpPageCubit, SignUpPageState>(
                            listener: (context, state) {
                              if (state is SignUpError) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(tr.messageProblem),
                                    content: Text(state.message),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: Text(tr.generalOk),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is SignUpSuccess) {
                                context.push(AppRoutes.bottomNavBar);
                              }
                            },
                            builder: (context, state) {
                              if (state is SignUpLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return SizedBox(
                                width: AppSizes.elevatedButtonSizeLarge().width,
                                height:
                                    AppSizes.elevatedButtonSizeLarge().height,
                                child: ElevatedButton(
                                  onPressed: () => cubit.SignUp(),
                                  child: Text(tr.generalSignUp),
                                ),
                              );
                            },
                          ),
                          AppSizes.verticalSpaceMedium(),

                          //-------------------------------------------------------------------------- do you have account
                          Row(
                            children: [
                              Expanded(
                                // <--- allow it to shrink
                                child: Text(
                                  tr.textDoYouHaveAccount,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.pop(),
                                child: Text(
                                  tr.generalSignIn,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
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
