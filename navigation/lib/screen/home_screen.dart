import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 안드로이드 뒤로가기 버튼을 제어할 수 있다.
        // true - pop 가능
        // false - pop 불가능
        return Navigator.of(context).canPop();
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              // 검정색 스크린
              Navigator.of(context).pop();
            },
            child: const Text('Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              // 더 이상 뒤로 갈 페이지가 없을 경우 실행이 안 된다.
              Navigator.of(context).maybePop();
            },
            child: const Text('Maybe Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: const Text('Can Pop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<int>(
                MaterialPageRoute(
                  builder: (context) => const RouteOneScreen(
                    number: 123,
                  ),
                ),
              );

              print(result);
            },
            child: const Text('Push'),
          ),
        ],
      ),
    );
  }
}
