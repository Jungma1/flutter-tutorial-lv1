import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({
    super.key,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          'arguments: $number',
          // mainAxisAlignment는 center로 되어있지만, 텍스트는 기본 왼쪽 정렬이다.
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: const Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          child: const Text('Maybe Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            // 라우터는 스택으로 이루어져 있고, 순차적으로 쌓인다.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const RouteTwoScreen(),
                // settings - 값을 넘겨주는 두 번째 방법
                settings: const RouteSettings(
                  arguments: 789,
                ),
              ),
            );
          },
          child: const Text('Push'),
        ),
      ],
    );
  }
}
