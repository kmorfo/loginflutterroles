import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/shared.dart';
import '../../auth.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Header(logoWidth: 120),
      const Positioned(bottom: 0, child: LogoFooter()),
      SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 155),
        CardContainer(child: _RecoverForm()),
      ]))
    ]));
  }
}

class _RecoverForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    final recoveryForm = ref.watch(recoveryFormProvider);

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
          Text('Recuperación de contraseña',
              style: textStyles.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Correo',
            icon: FontAwesomeIcons.at,
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(recoveryFormProvider.notifier).onEmailChange,
            errorMessage: recoveryForm.isFormPosted ? recoveryForm.email.errorMessage : null,
          ),
          const SizedBox(height: 32),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Enviar Email recuperación',
                buttonColor: Colors.black,
                onPressed: recoveryForm.isPosting
                    ? null
                    : ref.read(recoveryFormProvider.notifier).onFormSubmit,
              )),
          const SizedBox(height: 16),
          TextButton(
              onPressed: () => context.push('/login'),
              child: const Text('Volver al inicio de sesión')),
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
