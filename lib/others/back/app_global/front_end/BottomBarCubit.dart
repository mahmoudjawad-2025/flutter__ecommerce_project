import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get key => scaffoldKey;

  void ChangeIndex(int index) => emit(index);
}
