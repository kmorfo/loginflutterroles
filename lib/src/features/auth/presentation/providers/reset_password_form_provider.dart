import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../shared/infrastructure/inputs/inputs.dart';
import 'auth_provider.dart';

//! 3 - StateNotifierProvider - consume afuera
final resetPasswordFormProvider =
    StateNotifierProvider.autoDispose<ResetPasswordFormNotifier, ResetPasswordFormState>((ref) {
  final resetPasswordCallback = ref.watch(authProvider.notifier).resetPassword;

  return ResetPasswordFormNotifier(resetPasswordCallback: resetPasswordCallback);
});

//! 2 - Como implementamos un notifier
class ResetPasswordFormNotifier extends StateNotifier<ResetPasswordFormState> {
  final Function(String, String) resetPasswordCallback;

  ResetPasswordFormNotifier({required this.resetPasswordCallback})
      : super(ResetPasswordFormState());

  onToggleObscureText() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  onSetToken(String token) {
    state = state.copyWith(token: token);
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(password: newPassword, isValid: Formz.validate([newPassword]));
  }

  onFormSubmit() async {
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      password: password,
      isValid: Formz.validate( [password]) && state.token.isNotEmpty,
    );

    if (!state.isValid) return;
    state.copyWith(isPosting: true);
    await resetPasswordCallback(state.token, state.password.value);

    state.copyWith(isPosting: false);
  }
}

//! 1 - State del provider
class ResetPasswordFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String token;
  final Password password;
  final bool obscureText;

  ResetPasswordFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.token = '',
      this.password = const Password.pure(),
      this.obscureText = true});

  ResetPasswordFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          String? token,
          Password? password,
          bool? obscureText}) =>
      ResetPasswordFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          token: token ?? this.token,
          password: password ?? this.password,
          obscureText: obscureText ?? this.obscureText);

  @override
  String toString() {
    return '''
    ResetPasswordFormState:
      isPosting:    $isPosting
      isFormPosted: $isFormPosted
      isValid:      $isValid
      token:        $token
      password:     $password
      obscureText:  $obscureText
    ''';
  }
}
