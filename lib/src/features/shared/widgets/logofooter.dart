import 'package:flutter/material.dart';

class LogoFooter extends StatelessWidget {
  const LogoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final bool tablet = screenSize.width > 500;

    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(80)),
            gradient: LinearGradient(colors: [
              const Color.fromARGB(197, 236, 141, 141),
              colors.primary,
            ])),
        width: MediaQuery.of(context).size.width,
        height: tablet ? 110 : 80,
        child: const Image(
          image: AssetImage('assets/images/logorlujanSF.png'),
        ));
  }
}
