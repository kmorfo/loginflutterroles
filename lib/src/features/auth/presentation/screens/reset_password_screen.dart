import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/shared.dart';
import '../../auth.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String token;

  const ResetPasswordScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Header(logoWidth: 120),
      const Positioned(bottom: 0, child: LogoFooter()),
      SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 155),
        CardContainer(child: _ResetPasswordForm(token: token)),
      ]))
    ]));
  }
}

class _ResetPasswordForm extends ConsumerWidget {
  final String token;

  const _ResetPasswordForm({required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;
    final resetPasswordForm = ref.watch(resetPasswordFormProvider);

    // ref.read(resetPasswordFormProvider.notifier).onSetToken(token);

    Future(() {
      final stateToken = ref.read(resetPasswordFormProvider).token;
      if (stateToken.isEmpty) {
        ref.read(resetPasswordFormProvider.notifier).onSetToken(token);
        print('Desde resetpasswordscreen token:$token'); //TODO Borrar linea
      }
    });

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const FlutterLogo(size: 120),
          const SizedBox(height: 8),
          Text(
            'Cambio de contraseña',
            style: textStyles.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Contraseña',
            icon: resetPasswordForm.obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            onIconPressed: ref.read(resetPasswordFormProvider.notifier).onToggleObscureText,
            obscureText: resetPasswordForm.obscureText,
            onFieldSubmitted: (_) => {ref.read(resetPasswordFormProvider.notifier).onFormSubmit()},
            onChanged: ref.read(resetPasswordFormProvider.notifier).onPasswordChanged,
            errorMessage:
                resetPasswordForm.isFormPosted ? resetPasswordForm.password.errorMessage : null,
          ),
          const SizedBox(height: 32),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Cambiar contraseña',
                buttonColor: Colors.black,
                onPressed: resetPasswordForm.isPosting
                    ? null
                    : ref.read(resetPasswordFormProvider.notifier).onFormSubmit,
              )),
          const SizedBox(height: 16),
          TextButton(
              onPressed: () => context.push('/login'),
              child: const Text('Volver al inicio de sessión'))
        ],
      ),
    );
  }
}
