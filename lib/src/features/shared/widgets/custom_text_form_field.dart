import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final IconData? icon;
  final Function()? onIconPressed;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.onFieldSubmitted,
      this.icon,
      this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: borderRadius, bottomLeft: borderRadius, bottomRight: borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 5))
          ]),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
            focusedErrorBorder:
                border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
            isDense: true,
            label: label != null ? Text(label!) : null,
            hintText: hint,
            errorText: errorMessage,
            focusColor: colors.primary,
            //icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
            //  prefixIcon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
            suffixIcon: icon != null
                ? IconButton(
                    onPressed: onIconPressed, icon: Icon(icon, color: colors.primary.withOpacity(0.5), size: 32))
                : null),
      ),
    );
  }
}
