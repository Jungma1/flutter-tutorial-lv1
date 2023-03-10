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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TestWidget(label: 'Test1'),
            const TestWidget(label: 'Test2'),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('λΉλ!'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('$label build μ€ν!');

    return Container(
      child: Text(
        label,
      ),
    );
  }
}
