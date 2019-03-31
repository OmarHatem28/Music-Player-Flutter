import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';
import 'database/DatabaseClient.dart';

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
      Song song = new Song(map['id'], map['artist'], map['title'], map['album'],
          map['albumId'], map['duration'], map['uri'], map['albumArt']);
      _songs.add(song);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildPage(),
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
    );
  }

  Widget _buildPage() {
    if (_songs != null) {
      return ListView.builder(
          itemCount: _songs.length * 2,
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
      leading: song.albumArt == "null"
          ? Image.asset(
        "images/download.jpg",
        width: 80,
        height: 60,
      )
          : Image.file(
        getImage(song.albumArt),
        width: 80,
        height: 60,
      ),
      trailing: Icon(
        flag ? Icons.pause : Icons.play_arrow,
      ),
      subtitle: song.artist == "<unknown>" ? null : Text(song.artist),
      onTap: () {
        if (flag) {
          pause(song);
        } else {
          playLocal(song);
        }
        setState(() {
          flag = !flag;
        });
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

  dynamic getImage(String albumArt) {
    return File.fromUri(Uri.parse(albumArt));
  }
}