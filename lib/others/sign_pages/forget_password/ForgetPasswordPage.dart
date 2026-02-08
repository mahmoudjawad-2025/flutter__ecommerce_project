import 'package:ecommerce_app/common/widgets/ConfirmCloseButton.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:ecommerce_app/core/config/theme/ThemeExtentions.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/others/sign_pages/forget_password/PhoneStep%20.dart';
import 'package:ecommerce_app/others/sign_pages/forget_password/ResetPasswordStep.dart';
import 'package:ecommerce_app/others/sign_pages/forget_password/VCodeStep.dart';
import 'package:ecommerce_app/others/back/sign_pages/forget_password/ForgetPasswordCubit.dart';
import 'package:ecommerce_app/others/widgets_folder/AppBar1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final anim = Theme.of(context).extension<AppAnimationTheme>()!;
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      //-------------------------------------------------------------------------- Error + success snackbar
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(tr.messageSuccess),
              duration: const Duration(seconds: 2),
            ),
          );
          context.pop();
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: state.error == TextFeildValidationMessage.VCodeError
                  ? Text(
                      AppConstants.translateValidationMessage(
                        context,
                        TextFeildValidationMessage.VCodeError,
                      ),
                    )
                  : Text(
                      AppConstants.translateValidationMessage(
                        context,
                        TextFeildValidationMessage.feildsNotCompatableError,
                      ),
                    ),
            ),
          );
        }
      },
      //-------------------------------------------------------------------------- main
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();
        // AppConstants.setDeviceSize(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppSizes.appBarHeight()),
            child: AppBar1(isSignPage: true),
          ),
          body: Stack(
            children: [
              //-------------------------------------------------------------------------- close button
              const Positioned(
                top: 16, // adjust as you like
                left: 16,
                child: ConfirmCloseButton(),
              ),

              //-------------------------------------------------------------------------- Main content (centered)
              Center(
                child: AnimatedSwitcher(
                  duration: anim.normalDuration,
                  child: _buildStep(state, cubit),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //-------------------------------------------------------------------------- widgets according to emited state
  Widget _buildStep(ForgetPasswordState state, ForgetPasswordCubit cubit) {
    switch (state) {
      case ForgetPasswordInitial():
        return PhoneStep(
          cubit: cubit,
          state: state,
          key: const ValueKey("phone"),
        );

      case ForgetPasswordLoading():
        return const Center(child: CircularProgressIndicator());

      case ForgetPasswordCodeSent():
        return VCodeStep(
          cubit: cubit,
          state: state,
          key: const ValueKey("vcode"),
        );

      case ForgetPasswordVCodeVerified():
        return ResetPasswordStep(
          cubit: cubit,
          state: state,
          key: const ValueKey("reset"),
        );

      case ForgetPasswordError():
        return state.error == TextFeildValidationMessage.VCodeError
            ? VCodeStep(
                cubit: cubit,
                state: state,
                key: const ValueKey("vcode"),
              )
            : ResetPasswordStep(
                cubit: cubit,
                state: state,
                key: const ValueKey("reset"),
              );

      default:
        return PhoneStep(
          cubit: cubit,
          state: state,
          key: const ValueKey("phone"),
        );
    }
  }
}
