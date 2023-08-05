import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserScreen extends StatelessWidget {
  static const name = 'UserScreen';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Text('UserScreen'),
      ),
    );
  }
}
