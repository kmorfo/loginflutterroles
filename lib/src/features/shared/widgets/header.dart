import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bubble.dart';

class Header extends StatelessWidget {
  final double logoWidth;

  const Header({super.key, this.logoWidth = 180});

  @override
  Widget build(BuildContext context) {
    return IconHeader(
        icon: FontAwesomeIcons.clock,
        // logo: const Image(image: AssetImage('assets/images/logo.png')),
        logoWidth: logoWidth,
        color1: const Color.fromARGB(255, 216, 0, 4),
        color2: const Color(0xFFFF5D5F));
  }
}

class IconHeader extends StatelessWidget {
  final IconData icon;
  final Image? logo;
  final double logoWidth;
  final Color color1;
  final Color color2;

  const IconHeader({
    super.key,
    required this.icon,
    this.logo,
    required this.logoWidth,
    this.color1 = Colors.redAccent,
    this.color2 = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _IconHeaderBackGround(color1: color1, color2: color2),
      Positioned(
          top: -50,
          left: -70,
          child: FaIcon(icon, size: 250, color: Colors.white.withOpacity(0.2))),
      const Positioned(
          top: 10, right: 10, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 50)),
      const Positioned(
          top: 400, right: 180, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 50)),
      const Positioned(
          top: 80, right: 220, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 34)),
      const Positioned(
          top: 280, right: 250, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 85)),
      const Positioned(
          top: 232, right: 64, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 76)),
      const Positioned(
          top: 145, right: 120, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 30)),
      const Positioned(
          top: 400, right: 20, child: Bubble(color: Color.fromRGBO(255, 255, 255, 0.1), size: 130)),
      Column(children: [
        const SizedBox(height: 40),
        logo != null ? SizedBox(width: logoWidth, child: logo) : const SizedBox(),
        const SizedBox(height: 80, width: double.infinity),
        const SizedBox(height: 20),
        FaIcon(icon, size: 80, color: Colors.white.withOpacity(0.3))
      ])
    ]);
  }
}

class _IconHeaderBackGround extends StatelessWidget {
  final Color color1;
  final Color color2;

  const _IconHeaderBackGround({required this.color1, required this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.80,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, color2])));
  }
}
