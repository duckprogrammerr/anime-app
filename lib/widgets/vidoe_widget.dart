import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPlayer({
    required this.controller,
  });

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late ChewieController chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
        videoPlayerController: widget.controller,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        errorBuilder: (context, errorMsg) {
          return Center(
              child: Text(errorMsg,
                  style: TextStyle(
                    color: Colors.white,
                  )));
        });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(controller: chewieController),
    );
  }
}

class VideoDisplay extends StatelessWidget {
  final String videoUrl;
  VideoDisplay({required this.videoUrl});
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(controller: VideoPlayerController.network((videoUrl)));
  }
}
