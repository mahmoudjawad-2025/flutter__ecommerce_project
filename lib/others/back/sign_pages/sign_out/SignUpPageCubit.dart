import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'SignUpPageState.dart';

class SignUpPageCubit extends Cubit<SignUpPageState> {
  SignUpPageCubit() : super(SignUpInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //-------------------------------------------------------------------------- signUp button
  void SignUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final firstName = firstNameController.text.trim();
    // final lastName = lastNameController.text.trim();

    if (!formKey.currentState!.validate()) return;
    emit(SignUpLoading());

    await Future.delayed(const Duration(seconds: 1)); // simulate network call

    if (email == 't@t' &&
        password == '123456' &&
        confirmPassword == password &&
        // ignore: unnecessary_null_comparison
        firstName != null) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpError("Something went wrong!"));
    }
  }

  //-------------------------------------------------------------------------- close
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
