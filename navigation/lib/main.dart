import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

void main() {
  runApp(
    MaterialApp(
      // home: HomeScreen(),
      // 초기 로딩시 라우트 경로
      initialRoute: '/',
      routes: {
        // 라우트 key 값은 임시로 지정한 것 (올바른 주소는 아님)
        '/': (context) => const HomeScreen(),
        '/one': (context) => const RouteOneScreen(),
        '/two': (context) => const RouteTwoScreen(),
        '/three': (context) => const RouteThreeScreen(),
      },
    ),
  );
}
