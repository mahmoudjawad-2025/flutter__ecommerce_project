import 'dart:async';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'ForgetPasswordState.dart';

//-------------------------------------------------------------------------- gloabla varaiables
int constDuration = 10;

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final phoneController = TextEditingController();
  final vcodeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final phoneFormKey = GlobalKey<FormState>();
  final vcodeFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  String? fullPhoneNumber;
  String tempVCode = "1234";

  Timer? _timer;
  int _secondsRemaining = constDuration;
  bool _canResend = false;

  //-------------------------------------------------------------------------- step 1: send code
  void sendCode() async {
    if (!phoneFormKey.currentState!.validate()) return;

    fullPhoneNumber = phoneController.text.trim();
    emit(ForgetPasswordLoading());

    await Future.delayed(const Duration(seconds: 1));

    _startTimer();
    emit(
      ForgetPasswordCodeSent(
        secondsRemaining: _secondsRemaining,
        canResend: _canResend,
      ),
    );
  }

  //-------------------------------------------------------------------------- step 2: verify code
  void verifyVCode() async {
    if (!vcodeFormKey.currentState!.validate()) return;
    pauseTimer();
    emit(ForgetPasswordLoading());
    await Future.delayed(const Duration(seconds: 3));

    if (vcodeController.text.trim() == tempVCode) {
      _stopTimer();
      emit(ForgetPasswordVCodeVerified());
    } else {
      resumeTimer();
      emit(ForgetPasswordError(TextFeildValidationMessage.VCodeError));
      emit(
        ForgetPasswordCodeSent(
          secondsRemaining: _secondsRemaining,
          canResend: _canResend,
          // errorMessage: "Invalid code",
        ),
      );
    }
  }

  //-------------------------------------------------------------------------- step 3: reset password
  void resetPassword() async {
    if (!passwordFormKey.currentState!.validate()) return;

    emit(ForgetPasswordLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (newPasswordController.text.trim() ==
            confirmPasswordController.text.trim() &&
        newPasswordController.text.trim().length >= 4) {
      emit(ForgetPasswordSuccess());
    } else {
      emit(
        ForgetPasswordError(
          TextFeildValidationMessage.feildsNotCompatableError,
        ),
      );
    }
  }

  //-------------------------------------------------------------------------- resend code
  void resendCode() {
    if (!_canResend) return;

    _secondsRemaining = constDuration;
    _canResend = false;
    _startTimer();
    emit(
      ForgetPasswordCodeSent(
        secondsRemaining: _secondsRemaining,
        canResend: _canResend,
      ),
    );
  }

  //-------------------------------------------------------------------------- timer helpers
  // void _startTimer() {
  //   _timer?.cancel();
  //   _secondsRemaining = constDuration;
  //   _canResend = false;

  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (_secondsRemaining > 0) {
  //       _secondsRemaining--;
  //       emit(
  //         ForgetPasswordCodeSent(
  //           secondsRemaining: _secondsRemaining,
  //           canResend: _canResend,
  //         ),
  //       );
  //     } else {
  //       _canResend = true;
  //       timer.cancel();
  //       emit(ForgetPasswordCodeSent(secondsRemaining: 0, canResend: true));
  //     }
  //   });
  // }

  // void _stopTimer() {
  //   _timer?.cancel();
  // }
  //-------------------------------------------------------------------------- timer helpers
  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = constDuration;
    _canResend = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        emit(
          ForgetPasswordCodeSent(
            secondsRemaining: _secondsRemaining,
            canResend: _canResend,
          ),
        );
      } else {
        _canResend = true;
        timer.cancel();
        emit(ForgetPasswordCodeSent(secondsRemaining: 0, canResend: true));
      }
    });
  }

  // NEW: pause timer
  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // NEW: resume timer
  void resumeTimer() {
    if (_secondsRemaining > 0 && !_canResend) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          emit(
            ForgetPasswordCodeSent(
              secondsRemaining: _secondsRemaining,
              canResend: _canResend,
            ),
          );
        } else {
          _canResend = true;
          timer.cancel();
          emit(ForgetPasswordCodeSent(secondsRemaining: 0, canResend: true));
        }
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  //-------------------------------------------------------------------------- close
  @override
  Future<void> close() {
    _stopTimer();
    phoneController.dispose();
    vcodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
