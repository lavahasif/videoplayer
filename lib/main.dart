import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Video Player Demo',
      home: Scaffold(
        body: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  VideoPlayerScreen(
                    url: 'http://192.168.43.84/im/VID-20201002-WA0072.mp4',
                  ),
                  Text("http://192.168.43.84/im/VID-20201002-WA0072.mp4"
                      .replaceAll("http://192.168.43.84/im/", ""))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  VideoPlayerScreen(
                    url:
                        'http://192.168.43.84/im/Record_2020-07-10-18-26-50_169660707d6b2499b0694ce7653f9b6d.mp4',
                  ),
                  Text(
                      "http://192.168.43.84/im/Record_2020-07-10-18-26-50_169660707d6b2499b0694ce7653f9b6d.mp4"
                          .replaceAll("http://192.168.43.84/im/", ""))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            VideoPlayerScreen(
              url: 'http://192.168.43.84/im/VID-20200930-WA0103.mp4',
            ),
            SizedBox(
              height: 20,
            ),
            VideoPlayerScreen(
              url: 'http://192.168.43.84/im/up/Record_2020-06-02-14-19-43.mp4',
            ),
            SizedBox(
              height: 20,
            ),
            VideoPlayerScreen(
              url:
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  VideoPlayerScreen(
                    url:
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  ),
                  Text(
                      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
                          .replaceAll("https://flutter.github.io/assets-for-api-docs/assets/videos/", ""))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  VideoPlayerScreen({Key key, this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(widget.url
        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // If the video is playing, pause it.
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            // If the video is paused, play it.
            _controller.play();
          }
        });
      },
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(height: 500, child: VideoPlayer(_controller)),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
