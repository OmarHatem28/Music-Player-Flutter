import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';


class OnlinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnlinePageState();
}

class OnlinePageState extends State<OnlinePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        makeOnlineSearchView(),
//        YoutubePlayer(
//          context: context,
//          source: "nPt8bK2gbaU",
//          quality: YoutubeQuality.HD,
//          // callbackController is (optional).
//          // use it to control player on your own.
////          callbackController: (controller) {
////              _videoController = controller;
////          },
//        ),
      ],
    );
  }

  Widget makeOnlineSearchView() {
    return Card(
      child: ListTile(
        title: EditableText(
          controller: TextEditingController(text: ""),
          focusNode: FocusNode(),
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
          ),
          cursorColor: Colors.red,),
        trailing: Icon(Icons.search),
      ),
      elevation: 10.0,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
    );
  }

}