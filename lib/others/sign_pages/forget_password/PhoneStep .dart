import 'package:ecommerce_app/common/models/ValidatedTextField.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/others/back/sign_pages/forget_password/ForgetPasswordCubit.dart';
import 'package:flutter/material.dart';

class PhoneStep extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  final ForgetPasswordState state;

  const PhoneStep({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return SizedBox(
      width: AppSizes.signInPageFrameWidth(),
      child: Form(
        key: cubit.phoneFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizes.verticalSpaceMedium(),
            //-------------------------------------------------------------------------- title + subtitle
            Text(
              tr.titleStep1,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),
            Text(
              tr.customEnterYourPhone,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),

            //-------------------------------------------------------------------------- Phone Feild
            ValidatedTextField(
              label: "",
              icon: Icons.phone,
              controller: cubit.phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return TextFeildValidationMessage.feildRequired.name;
                }
                return null;
              },
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: AppSizes.verticalSpaceMedium().height! * 2),

            //-------------------------------------------------------------------------- button
            SizedBox(
              width: double.infinity,
              child: state is ForgetPasswordLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: state is ForgetPasswordLoading
                          ? null
                          : cubit.sendCode, // mock backend still works
                      child: Text(tr.buttonSend),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
