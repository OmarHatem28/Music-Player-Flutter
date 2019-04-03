import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';
import 'database/DatabaseClient.dart';

MusicFinder audioPlayer = new MusicFinder();

List<Map<String, dynamic>> records;
List<Song> _songs = new List();
List<Song> filtered = new List();
Song currSong;
int position;
TextEditingController _c;
bool beenHereb4 = false;

class AllSongs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AllSongsState();
}

class AllSongsState extends State<AllSongs> {

  @override
  void initState() {
    super.initState();
    if ( !beenHereb4 ){
      beenHereb4 = true;
      initPlayer();
    }
  }

  void initPlayer() async {
    _c = new TextEditingController();
    records = await DatabaseClient().createDB();
    for (Map<String, dynamic> map in records) {
      Song song = new Song(map['id'], map['artist'], map['title'], map['album'],
          map['albumId'], map['duration'], map['uri'], map['albumArt']);
      _songs.add(song);
    }
    setState(() {
      filtered.addAll(_songs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: makeLocalSearchView(),
            flex: 0,
          ),
          Expanded(child: _buildPage()),
        ],
      ),
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
//      height: 300,
    );
  }

  Widget _buildPage() {
    if (filtered != null) {
      return ListView.builder(
          itemCount: filtered.length * 2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return Divider();

            final index = i ~/ 2;
            return _buildTile(filtered[index]);
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
    audioPlayer.setCompletionHandler(() {
      stop(song);
      setState(() {
        position = song.duration;
      });
    });
    if (result == 1) setState(() => song.isPlaying = true);
  }

  pause(Song song) async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => song.isPlaying = false);
  }

  stop(Song song) async {
    final result = await audioPlayer.stop();
    if (result == 1) setState(() => song.isPlaying= false);
  }

  dynamic getImage(String albumArt) {
    return File.fromUri(Uri.parse(albumArt));
  }

  Widget makeLocalSearchView() {
    return Card(
      child: ListTile(
        title: TextField(
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Search for a Song",
          ),
          onChanged: (text) {
            filtered.clear();
            _songs.forEach((song) {
              if (song.title.toLowerCase().contains(text.toLowerCase())) {
                filtered.add(song);
              }
            });
            setState(() {});
          },
          controller: _c,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
          ),
        ),
        trailing: Icon(Icons.search),
      ),
      elevation: 10.0,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
    );
  }
}
