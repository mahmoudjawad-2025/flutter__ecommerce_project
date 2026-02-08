part of "SignUpPageCubit.dart";

abstract class SignUpPageState {}

class SignUpInitial extends SignUpPageState {}

class SignUpLoading extends SignUpPageState {}

class SignUpSuccess extends SignUpPageState {}

class SignUpError extends SignUpPageState {
  final String message;
  SignUpError(this.message);
}
