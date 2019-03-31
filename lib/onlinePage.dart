import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';


class OnlinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnlinePageState();
}

class OnlinePageState extends State<OnlinePage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        Card(
          child: ListTile(
            title: EditableText(
                controller: TextEditingController(text: "Hi"),
                focusNode: FocusNode(),
                style: TextStyle(
                  color: Colors.red,
                ),
                cursorColor: Colors.indigo),
            trailing: Icon(Icons.search),
            contentPadding: EdgeInsets.all(10.0),
          ),
          elevation: 10.0,
        ),
        _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Text("nope"),
        YoutubePlayer(
          context: context,
          source: "7QUtEmBT_-w",
          quality: YoutubeQuality.HD,
          // callbackController is (optional).
          // use it to control player on your own.
//          callbackController: (controller) {
//              _videoController = controller;
//          },
        ),
        Text("Omar")
      ],
    );
  }
}