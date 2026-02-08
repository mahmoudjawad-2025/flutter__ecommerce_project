import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/others/back/sign_pages/forget_password/ForgetPasswordCubit.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VCodeStep extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  final ForgetPasswordState state;

  const VCodeStep({super.key, required this.cubit, required this.state});
  //---------------- solve not msg when empty, and wrong msg when invalid
  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------------- variables
    final tr = AppLocalizations.of(context)!;
    // ignore: unused_local_variable
    final canResend = state is ForgetPasswordCodeSent
        ? (state as ForgetPasswordCodeSent).canResend
        : false;
    // ignore: unused_local_variable
    final secondsRemaining = state is ForgetPasswordCodeSent
        ? (state as ForgetPasswordCodeSent).secondsRemaining
        : 0;

    return SizedBox(
      width: AppSizes.signInPageFrameWidth(),
      child: Form(
        key: cubit.vcodeFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //-------------------------------------------------------------------------- title + subtitle
            Text(
              tr.titleStep2,
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),
            Text(tr.customEnterCode),
            SizedBox(height: AppSizes.verticalSpaceMedium().height!),

            //-------------------------------------------------------------------------- validation code feild by Pinput widget
            Center(
              child: Pinput(
                controller: cubit.vcodeController,
                length: 4,
                validator: (value) {
                  if (cubit.vcodeController.text.isEmpty ||
                      cubit.vcodeController.text.length < 4) {
                    return TextFeildValidationMessage.VCodeError.name;
                  }
                  return null;
                },
                errorTextStyle: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
                errorText: AppConstants.translateValidationMessage(
                  context,
                  TextFeildValidationMessage.VCodeError,
                ),
              ),
            ),

            //-------------------------------------------------------------------------- submit button
            SizedBox(height: AppSizes.verticalSpaceMedium().height!),
            SizedBox(
              width: double.infinity,
              child: state is ForgetPasswordLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: cubit.verifyVCode,
                      child: Text(tr.buttonSubmit),
                    ),
            ),

            SizedBox(height: AppSizes.verticalSpaceMedium().height!),

            //-------------------------------------------------------------------------- timer + Resend button
            if (state is ForgetPasswordCodeSent) ...[
              SizedBox(height: AppSizes.verticalSpaceMedium().height!),
              Text(
                "${tr.textTimeRemaining} ${(state as ForgetPasswordCodeSent).secondsRemaining}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: AppSizes.verticalSpaceMedium().height!),
              if ((state as ForgetPasswordCodeSent).canResend)
                TextButton(
                  onPressed: cubit.resendCode,
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.paddingSmall()),
                    child: Text(tr.buttonResendAgain),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
