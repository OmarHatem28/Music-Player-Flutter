import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'database/DatabaseClient.dart';

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
  List<Map<String, dynamic>> records;
  List<Song> _songs = new List();
  Song currSong;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    records = await DatabaseClient().createDB();
    for (Map<String, dynamic> map in records) {
      Song song = new Song(map['id'], map['artist'], map['title'], map['album'], map['albumId'], map['duration'], map['uri'], map['albumArt']);
      _songs.add(song);
    }
    setState(() {
      print(_songs[1].title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    if ( _songs != null ){
      return ListView.builder(
          itemCount: _songs.length*2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return Divider();

            final index = i ~/ 2;
            return _buildTile(_songs[index]);
          });
    }
    return Text("Hello");
  }

  Widget _buildTile(Song song) {
    bool flag = song.isPlaying;
    return ListTile(
      title: Text(
        song.title,
        overflow: TextOverflow.fade,
      ),
      trailing: Icon(
        flag ? Icons.pause : Icons.play_arrow,
      ),
      onTap: () {
        if (flag) {
          pause(song);
          setState(() {
            flag = !flag;
          });
        } else {
          playLocal(song);
          setState(() {
            flag = !flag;
          });
        }
      },
    );
  }

  playLocal(Song song) async {
    if (currSong != null && currSong.id != song.id) {
      currSong.isPlaying = false;
      audioPlayer.stop();
    }
    currSong = song;
    final result = await audioPlayer.play(song.uri, isLocal: true);
    if (result == 1) setState(() => song.isPlaying = true);
  }

  pause(Song song) async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => song.isPlaying = false);
  }

  stop() async {
    final result = await audioPlayer.stop();
//    if (result == 1) setState(() => playerState = PlayerState.stopped);
  }
}
