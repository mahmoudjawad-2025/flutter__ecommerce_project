import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'SignInPageState.dart';

class SignInPageCubit extends Cubit<SignInPageState> {
  SignInPageCubit() : super(SignInInitial());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasShownValidationMessages = false;

  //-------------------------------------------------------------------------- signIn
  void signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    hasShownValidationMessages = true;

    if (!formKey.currentState!.validate()) return;
    emit(SignInLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (email == 't@t' && password == '123456') {
      emit(SignInSuccess());
    } else {
      emit(SignInError(TextFeildValidationMessage.invalidEmailOrPassword));
    }
  }

  //-------------------------------------------------------------------------- close
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
