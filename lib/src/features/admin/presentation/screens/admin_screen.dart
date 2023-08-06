import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatelessWidget {
  static const name = 'AdminScreen';

  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Text('AdminScreen'),
      ),
    );
  }
}
