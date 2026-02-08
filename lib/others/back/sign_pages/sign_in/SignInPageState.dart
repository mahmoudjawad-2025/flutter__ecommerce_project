part of "SignInPageCubit.dart";

abstract class SignInPageState {}

class SignInInitial extends SignInPageState {}

class SignInLoading extends SignInPageState {}

class SignInSuccess extends SignInPageState {}

class SignInError extends SignInPageState {
  final TextFeildValidationMessage message;
  SignInError(this.message);
}
