import 'package:ecommerce_app/others/back/app_global/core_folder/CoreCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmCloseButton extends StatelessWidget {
  const ConfirmCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        context.read<CoreCubit>().confirmClose(context);
      },
    );
  }
}
