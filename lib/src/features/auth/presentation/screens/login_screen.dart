import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/shared.dart';
import '../../auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Header(logoWidth: 120),
      const Positioned(bottom: 0, child: LogoFooter()),
      SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 155),
        CardContainer(child: _LoginForm()),
      ]))
    ]));
  }
}

class _LoginForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    final loginForm = ref.watch(loginFormProvider);

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
          Text('Inicio de sesión', style: textStyles.titleMedium),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Correo',
            icon: FontAwesomeIcons.at,
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage: loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 32),
          CustomTextFormField(
            label: 'Contraseña',
            icon: loginForm.obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            onIconPressed: ref.read(loginFormProvider.notifier).onToggleObscureText,
            obscureText: loginForm.obscureText,
            onFieldSubmitted: (_) => ref.read(loginFormProvider.notifier).onFormSubmit(),
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 32),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Ingresar',
                buttonColor: Colors.black,
                onPressed:
                    loginForm.isPosting ? null : ref.read(loginFormProvider.notifier).onFormSubmit,
              )),
          const SizedBox(height: 16),
          TextButton(
              onPressed: () => context.push('/recovery-password'),
              child: const Text('¿Olvidó su contraseña?')),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                  onPressed: () => context.push('/register'), child: const Text('Crea una aquí'))
            ],
          ),
        ],
      ),
    );
  }
}
