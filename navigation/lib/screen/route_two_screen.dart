import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

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
        ElevatedButton(
          onPressed: () {
            // Push Replacement
            // ㄴ RouteThreeScreen 에서 pop 시 RouteOneScreen으로 이동된다.
            // 원래라면 [HomeScreen(), RouteOneScreen(), RouteTwoScreen(), RouteThreeScreen()] 스택으로 쌓여야 하지만,
            // pushReplacement() 는 [HomeScreen(), RouteOneScreen(), RouteThreeScreen()] 으로 기존 스택을 대체 시킨다.
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const RouteThreeScreen(),
              ),
            );
          },
          child: const Text('Push Replacement'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: const Text('Push Replacement Named'),
        ),
        ElevatedButton(
          onPressed: () {
            // push 되는 라우트를 제외하고 스택이 지워진다.
            // 단, 두 번째 파라미터로 기존 라우트 스택에서 비교하여 특정 라우트를 유지 시킬 수 있다.
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const RouteThreeScreen(),
              ),
              // HomeScreen() 이 유지된다.
              (route) => route.settings.name == '/',
            );
          },
          child: const Text('Push And Remove Until'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) => route.settings.name == '/',
            );
          },
          child: const Text('Push Named And Remove Until'),
        ),
      ],
    );
  }
}
