import 'package:ecommerce_app/common/models/ValidatedTextField.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/others/back/sign_pages/forget_password/ForgetPasswordCubit.dart';
import 'package:flutter/material.dart';

class ResetPasswordStep extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  final ForgetPasswordState state;

  const ResetPasswordStep({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return SizedBox(
      width: AppSizes.signInPageFrameWidth(),
      child: Form(
        key: cubit.passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //-------------------------------------------------------------------------- title
            Text(
              tr.titleStep3,
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            //-------------------------------------------------------------------------- password feild
            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),
            ValidatedTextField(
              label: tr.labelNewPassword,
              icon: Icons.lock,
              controller: cubit.newPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return TextFeildValidationMessage.feildRequired.name;
                } else if (value.length < 4) {
                  return TextFeildValidationMessage.lengthError.name;
                }
                return null;
              },
              obscureText: true,
            ),

            //-------------------------------------------------------------------------- confirm password feild
            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),
            ValidatedTextField(
              label: tr.labelConfirmPassword,
              icon: Icons.lock,
              controller: cubit.confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return TextFeildValidationMessage.feildRequired.name;
                } else if (value.length < 4) {
                  return TextFeildValidationMessage.lengthError.name;
                } else
                  return null;
              },
              obscureText: true,
            ),

            //-------------------------------------------------------------------------- Button + progress indicator
            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),
            SizedBox(
              width: double.infinity,
              child: state is ForgetPasswordLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed:
                          cubit.resetPassword, // mock backend still works
                      child: Text(tr.buttonReset),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
