import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../shared/infrastructure/inputs/inputs.dart';
import 'auth_provider.dart';

//! 3 - StateNotifierProvider - consume afuera
final recoveryFormProvider =
    StateNotifierProvider.autoDispose<RecoveryFormNotifier, RecoveryFormState>((ref) {
  final recoveryUserCallback = ref.watch(authProvider.notifier).recoveryPassword;

  return RecoveryFormNotifier(recoveryUserCallback: recoveryUserCallback);
});

//! 2 - Como implementamos un notifier
class RecoveryFormNotifier extends StateNotifier<RecoveryFormState> {
  final Function(String) recoveryUserCallback;

  RecoveryFormNotifier({required this.recoveryUserCallback}) : super(RecoveryFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(email: newEmail, isValid: Formz.validate([newEmail]));
  }

  onFormSubmit() async {
    final email = Email.dirty(state.email.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      isValid: Formz.validate([email]),
    );

    if (!state.isValid) return;
    state.copyWith(isPosting: true);
    await recoveryUserCallback(state.email.value);

    state.copyWith(isPosting: false);
  }
}

//! 1 - State del provider
class RecoveryFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;

  RecoveryFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.email = const Email.pure()});

  RecoveryFormState copyWith({bool? isPosting, bool? isFormPosted, bool? isValid, Email? email}) =>
      RecoveryFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email);

  @override
  String toString() {
    return '''
    RecoveryFormState:
      isPosting:    $isPosting
      isFormPosted: $isFormPosted
      isValid:      $isValid
      email:        $email
    ''';
  }
}
