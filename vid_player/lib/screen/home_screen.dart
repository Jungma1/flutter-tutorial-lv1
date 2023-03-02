import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  Widget renderEmpty() {
    return Container(
      // StatefulWidget 에서는 context 를 어디에서나 가져올 수 있다.
      width: MediaQuery.of(context).size.width,
      // BoxDecoration - color 로 지정해주는 것이 정석이다.
      // Container - color 와 BoxDecoration - color 둘중 하나만 넣어야 한다.
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    // pickVideo() 대신에 pickImage()를 사용하면 이미지를 불러와 사용할 수 있다.
    final video = await ImagePicker().pickVideo(
      // ImageSource.camera - 카메라
      // ImageSource.gallery - 사진첩
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      // 그라데이션 설정
      gradient: LinearGradient(
        // 시작 지점 Alignment 로 지정
        begin: Alignment.topCenter,
        // 끝나는 지점 Alignment 로 지정
        end: Alignment.bottomCenter,
        // colors 배열 순서대로 색상 지정
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          // copyWith() - 기존 설정을 유지한 채 설정을 추가할 수 있다.
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
