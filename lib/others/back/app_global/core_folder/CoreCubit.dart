import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'CoreState.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreInitial());

  Future<void> confirmClose(BuildContext context) async {
    final tr = AppLocalizations.of(context)!;
    emit(CoreLoading());
    //-------------------------------------------------------------------------- main show
    try {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(tr.generalCancel),
          content: Text(tr.messageAreYouSure),
          actions: [
            TextButton(
              onPressed: () => ctx.pop(false),
              child: Text(tr.generalNo),
            ),
            TextButton(
              onPressed: () => ctx.pop(true),
              child: Text(tr.generalYes),
            ),
          ],
        ),
      );
      //-------------------------------------------------------------------------- determine result
      if (confirm == true) {
        // ignore: use_build_context_synchronously
        context.pop();
        emit(CoreSuccess());
      } else {
        emit(CoreCancelled());
      }
    } catch (e) {
      emit(CoreFailure(e.toString()));
    }
  }
}
