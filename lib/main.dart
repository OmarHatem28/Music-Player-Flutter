import 'package:flutter/material.dart';
import 'package:music_player/allSongs.dart';
import 'package:music_player/playlists.dart';
import 'package:music_player/onlinePage.dart';
import 'package:music_player/scanSongs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        './scanSongs': (BuildContext context) => ScanSong(),
      },
      home: MyHome(),
//      theme: ThemeData.dark(),
    );
  }
}

class MyHome extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Online'),
    Tab(text: 'All Songs'),
    Tab(text: 'Playlists'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Music player"),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            return buildNavPage(tab.text, context);
          }).toList(),
        ),
        drawer: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 80, 0),
//            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/music_cover.jpg',
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
                Divider(),
                ListTile(
                  title: Text("Scan for New Songs"),
                  onTap: () {
                    print("Pressed");
                    Navigator.of(context).pushNamed('./scanSongs');
                  },
                  trailing: Icon(Icons.search),
                ),
                Divider(),
              ],
            )),
      ),
    );
  }

  Widget buildNavPage(String text, BuildContext context) {
    if (text == "Online") {
      return OnlinePage();
    } else if (text == 'All Songs') {
      return AllSongs();
    }
    return PlayList();
  }
}
