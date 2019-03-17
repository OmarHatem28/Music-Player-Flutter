import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Music player"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  MusicFinder audioPlayer = new MusicFinder();
  var _songs;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    var songs = await MusicFinder.allSongs();
    songs = new List.from(songs);

    setState(() {
      _songs =  songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (context, int i) {
          return ListTile(
            title: Text(_songs[i].title),
            onTap: () => playLocal(_songs[i].uri),
          );
        });
  }

  Future playLocal(String url) async {
    final result = await audioPlayer.play(url, isLocal: true);
    if ( result == 1 ){

    }
  }
}
