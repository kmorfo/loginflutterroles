import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FadeInDownBig(
                child: SpinPerfect(
                    infinite: true,
                    child: const SizedBox(
                        width: 110,
                        height: 110,
                        child: Image(
                          image: AssetImage('assets/images/logoIco.png'),
                        ))))));
  }
}
