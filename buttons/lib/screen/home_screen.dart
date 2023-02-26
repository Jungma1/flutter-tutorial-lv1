import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('버튼'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green[500];
                  }

                  return Colors.green;
                }),
                textStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    );
                  }

                  return const TextStyle(
                    fontSize: 10.0,
                  );
                }),
              ),
              child: const Text('CustomButton'),
            ),
            // 상태에 따른 버튼 스타일 지정
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                // MaterialState - 플러터 전반에서 사용되는 상태값
                //
                // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태)
                // focused - 포커스 상태 (텍스트 필드)
                // pressed - 눌림 상태
                // dragged - 드래그 상태
                // selected - 선택 상태 (체크박스, 라디오 버튼)
                // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 된 상태
                // disabled - 비활성화 상태
                // error - 에러 상태
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // 눌림 상태에 따른 기본 색상 변경
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }

                  return Colors.black;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  // 눌림 상태에 따른 글자 및 애니메이션 색상 변경
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }

                  return Colors.red;
                }),
                padding: MaterialStateProperty.resolveWith((states) {
                  // 눌림 상태에 따른 패딩 변경
                  if (states.contains(MaterialState.pressed)) {
                    return const EdgeInsets.all(100.0);
                  }

                  return const EdgeInsets.all(20.0);
                }),
              ),
              child: const Text('ButtonStyle'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // 기본 색상
                backgroundColor: Colors.red,
                // 글자 및 애니메이션 색상
                foregroundColor: Colors.black,
                // 그림자 색상
                shadowColor: Colors.green,
                // 3D 입체감의 깊이
                elevation: 10.0,
                // 글자 스타일
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                padding: const EdgeInsets.all(32.0),
                // 버튼 테두리
                side: const BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              child: const Text(
                'ElevatedButton',
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                // 글자 및 애니메이션 색상
                foregroundColor: Colors.green,
              ),
              child: const Text(
                'OutlinedButton',
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.brown,
              ),
              child: const Text(
                'TextButton',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
