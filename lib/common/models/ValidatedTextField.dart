import 'package:ecommerce_app/core/config/AppSizes.dart';
// import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ValidatedTextField extends StatelessWidget {
  //--------------------------------------------------------------------------  main section
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  const ValidatedTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    // final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final errorColor = Theme.of(context).colorScheme.error;
    // final tr = AppLocalizations.of(context)!;

    //-------------------------------------------------------------------------- special case: phone field
    if (keyboardType == TextInputType.phone) {
      return FormField<String>(
        validator: validator,
        initialValue: controller.text,
        builder: (field) {
          return IntlPhoneField(
            key: ValueKey(
              Localizations.localeOf(context).languageCode,
            ), // force rebuild for invalidNumberMessage translation operation
            controller: controller,
            keyboardType: TextInputType.phone,
            initialCountryCode: 'US',
            autovalidateMode: AutovalidateMode.disabled,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(
                icon,
                color: field.hasError
                    ? errorColor
                    : Theme.of(context).inputDecorationTheme.prefixIconColor,
                size: Theme.of(context).iconTheme.size! * 0.8,
              ),
              errorText: field.errorText == null
                  ? null
                  : AppConstants.translateValidationMessage(
                      context,
                      TextFeildValidationMessage.values.firstWhere(
                        (e) => e.name == field.errorText,
                      ),
                    ),
            ).applyDefaults(Theme.of(context).inputDecorationTheme),
            invalidNumberMessage: AppConstants.translateValidationMessage(
              context,
              TextFeildValidationMessage.phoneError,
            ),
            onChanged: (phone) {
              field.didChange(phone.completeNumber);
            },
          );
        },
      );
    }

    //-------------------------------------------------------------------------- normal text feild
    return FormField<String>(
      validator: validator,
      initialValue: controller.text,
      builder: (field) {
        // final hasError = field.hasError;
        return TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          // focusNode: field.focusNode,
          onChanged: field.didChange,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Padding(
              padding: EdgeInsets.all(AppSizes.paddingSmall() * 3),
              child: Icon(
                icon,
                color: field.hasError ? errorColor : iconColor,
                size: Theme.of(context).iconTheme.size! * 0.8,
              ),
            ),
            errorText: field.errorText == null
                ? null
                : AppConstants.translateValidationMessage(
                    context,
                    TextFeildValidationMessage.values.firstWhere(
                      (e) => e.name == field.errorText,
                    ),
                  ),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
        );
      },
    );
  }
}
