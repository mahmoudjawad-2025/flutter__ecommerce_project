part of 'ForgetPasswordCubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

// class ForgetPasswordCodeSent extends ForgetPasswordState {}
class ForgetPasswordCodeSent extends ForgetPasswordState {
  final int secondsRemaining;
  final bool canResend;
  // final String? errorMessage;

  ForgetPasswordCodeSent({
    required this.secondsRemaining,
    required this.canResend,
    // this.errorMessage,
  });
  ForgetPasswordCodeSent copyWith({
    int? secondsRemaining,
    bool? canResend,
    // String? errorMessage,
  }) {
    return ForgetPasswordCodeSent(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
      // errorMessage: errorMessage,
    );
  }
}

class ForgetPasswordVCodeVerified extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final TextFeildValidationMessage error;
  ForgetPasswordError(this.error);
}
