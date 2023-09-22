// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';

part 'side_menu_state.dart';

class SideMenuCubit extends Cubit<SideMenuState> {
  SideMenuCubit() : super(SideMenuInitial());

  Future<void> logoutClick() async {
    emit(SideMenuLoading());
    try {
      await UserRepository().logout();
      emit(LogoutActionState());
    } catch (e) {
      emit(ErrorActionState());
    }
  }

  Future<void> navigateToWallet() async {
    emit(SideMenuLoading());
    try {
      emit(WalletActionState());
    } catch (e) {
      emit(ErrorActionState());
    }
  }

  Future<void> navigateToProfile() async {
    emit(SideMenuLoading());
    try {
      emit(ProfileActionState());
    } catch (e) {
      emit(ErrorActionState());
    }
  }
}