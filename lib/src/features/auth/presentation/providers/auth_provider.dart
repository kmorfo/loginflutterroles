import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/shared.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastruture.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final AuthRepository authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } catch (e) {
      logout((e is CustomError) ? e.message : 'Error no controlado');
    }
  }

  Future<void> registerUser(String fullName, String email, String password) async {
    try {
      final user = await authRepository.register(fullName, email, password);
      _setLoggedUser(user);
    } catch (e) {
      logout((e is CustomError) ? e.message : 'Error no controlado');
    }
  }

  Future<void> recoveryPassword(String email) async {
    try {
      final bool result = await authRepository.recoveryPassword(email);
      if (result) {
        state = state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage:
              'Se envió un email de recuperación, \nrevise la bandeja de entrada\n y siga las intrucciones.',
        );
      }
    } catch (e) {
      logout((e is CustomError) ? e.message : 'Error no controlado');
    }
  }

  void _setLoggedUser(User user) async {
    //Guardamos el token el el shared preferences
    await keyValueStorageService.setKeyValue('token', user.token);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  void logout([String? errorMessage]) async {
    //Eliminamos el token de las shared prefs
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({this.authStatus = AuthStatus.checking, this.user, this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
