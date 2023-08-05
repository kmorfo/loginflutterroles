import 'package:flutter/material.dart';

/// Este Widget sera el contenedor de otro widget enviado por parametros
/// con la configuracion especificada
class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 60),
            decoration: _createCardShape(scaffoldBackgroundColor),
            child: child));
  }

  BoxDecoration _createCardShape(Color color) => BoxDecoration(
      color: color.withOpacity(0.95) ,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))]);
}
