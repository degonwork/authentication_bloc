import 'dart:async';
import 'package:authenticate_bloc/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  AuthenticationBloc({required AuthenticationService authenticationService})
      : _authenticationService = authenticationService,
        super(AuthenticationInitial()) {
    on<AppLoaded>(_mapAppLoaded);
    on<UserLoggedIn>(_mapUserLogged);
    on<UserLoggedOut>(_mapUserLoggedOut);
  }

  Future<void> _mapAppLoaded(
    AppLoaded event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final currentUser = await _authenticationService.getCurrentUser();
      if (currentUser != null) {
        emit(AuthenticationAuthenticated(user: currentUser));
      } else {
        emit(AuthenticationNotAuthenticated());
      }
    } catch (e) {
      emit(
        AuthenticationFailure(message: e.toString()),
      );
    }
  }

  Future<void> _mapUserLogged(
    UserLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationAuthenticated(user: event.user));
  }

  Future<void> _mapUserLoggedOut(
    UserLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationService.signOut();
    emit(AuthenticationNotAuthenticated());
  }
}
