import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String token;
   
  const ResetPasswordScreen({Key? key, required this.token}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    print('Desde resetpasswordscreen token:$token');
    return const Scaffold(
      body: Center(
         child: Text('ResetPasswordScreen'),
      ),
    );
  }
}