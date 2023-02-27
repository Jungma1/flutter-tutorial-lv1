import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute.of(context) - 가장 가까운 스크린 RouteTwoScreen을 가져온다.
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments: $arguments',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            // Named Route 방식
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
          },
          child: const Text('Push Named'),
        ),
      ],
    );
  }
}
