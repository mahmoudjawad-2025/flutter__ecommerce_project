part of 'CoreCubit.dart';

abstract class CoreState {}

class CoreInitial extends CoreState {}

class CoreLoading extends CoreState {}

class CoreSuccess extends CoreState {}

class CoreCancelled extends CoreState {}

class CoreFailure extends CoreState {
  final String message;
  CoreFailure(this.message);
}
