import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
    super.key,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = const Duration();
  bool showControls = false;

  @override
  void initState() {
    super.initState();

    // initState() 에서는 async 를 사용할 수 없다.
    // 따라서, 외부의 함수를 만들어서 실행시킨다.
    initializeController();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 영상이 변경됐을 경우 initializeController() 실행 시킨다.
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  void initializeController() async {
    // didUpdateWidget() 실행으로 영상이 변경될 시 기존에 남아있던 currentPosition 값으로 인해 오류가 발생할 수 있다.
    // 따라서, currentPosition 값을 초기화 해준다.
    // + await videoController!.initialize(); 는 비동기로 실행되기 때문에 maxPosition 값이 일시적으로 0인 순간이 생긴다.
    // ㄴ 0인 순간에는 Slider 의 max 파라미터에 값이 0이 되므로 비동기가 끝나기 전까지는 0 ~ 0 범위의 슬라이더가 생성되어 value 범위의 에러가 생긴다.
    currentPosition = const Duration();

    videoController = VideoPlayerController.file(
      // XFile 타입을 File 타입으로 변경
      File(widget.video.path),
    );

    await videoController!.initialize();

    // 슬라이더와 영상을 동기화 해주기 위한 리스너 등록
    // addListener - videoController 의 값이 변경될 때만 실행된다.
    videoController!.addListener(() async {
      final currentPosition = videoController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    // build() 를 재실행 시키기 위해 작성
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      // 로딩
      return const CircularProgressIndicator();
    }

    // AspectRatio - 영상 비율를 조정할 수 있다.
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio,
      // Stack - 위젯을 중첩 시킨다. (동영상 위에 버튼들)
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            if (showControls)
              _Controls(
                isPlaying: videoController!.value.isPlaying,
                onPlayPressed: onPlayPressed,
                onReversePressed: onReversePressed,
                onForwardPressed: onForwardPressed,
              ),
            if (showControls)
              _NewVideo(
                onPressed: widget.onNewVideoPressed,
              ),
            _SliderBottom(
              currentPosition: currentPosition,
              maxPosition: videoController!.value.duration,
              onSliderChanged: onSliderChanged,
            ),
          ],
        ),
      ),
    );
  }

  void onSliderChanged(double value) {
    // videoController 의 리스너는 videoController 의 값이 변경될 때만 실행된다.
    // 주석 처리된 아래 코드는 currentPosition 값만 변경하였고, 직접적으로 videoController 의 값은 변경하지 않았다.
    // 따라서, 사용자가 슬라이더를 움직였을 때 영상의 시간은 변하지 않는다.
    videoController!.seekTo(Duration(seconds: value.toInt()));
    // 잘못된 코드
    // setState(() {
    //   currentPosition = Duration(seconds: value.toInt());
    // });
  }

  void onPlayPressed() {
    // 이미 실행 중이면 중지
    // 실행 중이 아니면 실행
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    // 현재 영상 위치가 3초보다 작을 경우 0초(시작위치)로 이동한다.
    Duration position = const Duration();

    // 현재 영상 위치가 3초보다 클 경우에만 3초 이전으로 이동한다.
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }

    // seekTo() - 영상 시간 이동 함수
    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    // 영상 전체 길이
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition;

    if ((maxPosition - const Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + const Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;

  const _Controls({
    required this.isPlaying,
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // withOpacity - 색상 투명도 지정
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    // IconData - Icon(...) 의 파라미터 타입을 정의한 클래스이다.
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(
        iconData,
      ),
    );
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Positioned - 위치를 정하는 위젯 (Stack 에서 많이 사용)
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        iconSize: 30.0,
        icon: const Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _SliderBottom({
    required this.currentPosition,
    required this.maxPosition,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              // currentPosition.inSeconds % 60 - 60초 까지만 보이도록 하기 위함
              // padLeft(보여줄 글자 수, 대체할 글자) - 0:00 초 단위를 표현하기 위해 사용하였다.
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                // onChanged 는 슬라이더를 직접적으로 움직일 때만 실행된다.
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
              ),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
