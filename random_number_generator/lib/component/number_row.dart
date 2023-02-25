import 'package:flutter/material.dart';

// 중복된 코드들 컴포넌트로 만들어 재활용한다.
class NumberRow extends StatelessWidget {
  final int number;

  const NumberRow({
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number
          .toString()
          .split('')
          .map((e) => Image.asset(
                'asset/img/$e.png',
                width: 50.0,
                height: 70.0,
              ))
          .toList(),
    );
  }
}
