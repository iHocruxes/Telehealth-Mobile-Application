// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this._userRepository) : super(LogInInitial());
  final UserRepository _userRepository;

  void navigateToSignIn() {
    emit(NavigateToSignUpActionState());
  }

  Future<void> signIn(String email, String password) async {
    try {
      LoginResponse response = await _userRepository.login(email, password);
      emit(SignInActionState(response: response));
    } catch (error) {
      emit(LogInErrorActionState(message: error.toString()));
    }
  }
}
