import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/shared.dart';
import '../providers/providers.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Header(logoWidth: 120),
      const Positioned(bottom: 0, child: LogoFooter()),
      SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 155),
        CardContainer(child: _RegisterForm()),
      ]))
    ]));
  }
}

class _RegisterForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    final loginForm = ref.watch(registerFormProvider);

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
          Text('Registro', style: textStyles.titleMedium),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Nombre Completo',
            icon: FontAwesomeIcons.user,
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onFullNameChange,
            errorMessage: loginForm.isFormPosted ? loginForm.fullName.errorMessage : null,
          ),
          const SizedBox(height: 32),
          CustomTextFormField(
            label: 'Correo',
            icon: FontAwesomeIcons.at,
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 32),
          CustomTextFormField(
            label: 'Contraseña',
            icon: loginForm.obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            onIconPressed: ref.read(registerFormProvider.notifier).onToggleObscureText,
            obscureText: loginForm.obscureText,
            onFieldSubmitted: (_) => ref.read(registerFormProvider.notifier).onFormSubmit(),
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 32),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Registrarse',
                buttonColor: Colors.black,
                onPressed: loginForm.isPosting
                    ? null
                    : ref.read(registerFormProvider.notifier).onFormSubmit,
              )),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                  onPressed: () => context.push('/login'), child: const Text('Inicia sessión aquí'))
            ],
          ),
        ],
      ),
    );
  }
}
