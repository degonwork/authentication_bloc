import 'dart:async';
import 'package:authenticate_bloc/blocs/authentication/authentication_bloc.dart';
import 'package:authenticate_bloc/exceptions/authenticate_exception.dart';
import 'package:authenticate_bloc/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;
  LoginBloc({
    required AuthenticationBloc authenticationBloc,
    required AuthenticationService authenticationService,
  })  : _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitial()) {
    on<LoginInWithEmailAndPasswordPressed>(_mapLoginWithEmailAndPassword);
  }

  Future<void> _mapLoginWithEmailAndPassword(
    LoginInWithEmailAndPasswordPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _authenticationService.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        emit(LoginSuccess());
        emit(LoginInitial());
      } else {
        emit(const LoginFailure(error: 'Something very weird just happened'));
      }
    } on AuthenticationException catch (e) {
      emit(LoginFailure(error: e.message));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
