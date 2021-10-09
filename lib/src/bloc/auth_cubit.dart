import 'dart:async';

import 'package:agrovision/src/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryBase _authRepository;
  late StreamSubscription _authSubscription;

  AuthCubit(this._authRepository) : super(AuthInitialState());
  Future<void> init() async {
    // await Future.delayed(Duration(seconds: 3));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  void _authStateChanged(AuthUser? user) =>
      user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));

  Future<void> signInAnonymously() =>
      _signIn(_authRepository.signInAnonymously());

  Future<void> signInWithGoogle() =>
      _signIn(_authRepository.signInWithGoogle());

  Future<void> _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      final user = await auxUser;
      if (user == null) {
        emit(AuthError('Unknown error, try again later'));
      } else {
        emit(AuthSignedIn(user));
      }
    } catch (e) {
      emit(AuthError('Error:${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthSignedOut extends AuthState {}

class AuthSigningIn extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignedIn extends AuthState {
  final AuthUser user;
  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}
