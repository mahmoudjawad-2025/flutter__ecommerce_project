part of 'AppBarCubit.dart';

class AppBarState {}

class AppBarInitial extends AppBarState {}

class AppBarLoading extends AppBarState {}

class AppBarSuccess extends AppBarState {}

class AppBarError extends AppBarState {
  final String message;
  AppBarError({required this.message});
}
