import 'package:flutter/material.dart';
import 'package:music_player/allSongs.dart';
import 'package:music_player/playlists.dart';
import 'package:music_player/onlinePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Online'),
    Tab(text: 'All Songs'),
    Tab(text: 'Playlists'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: MaterialApp(
        home: Scaffold(
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
        ),
      ),
    );
  }

  Widget buildNavPage(String text, BuildContext context) {
    if (text == "Online") {
      return OnlinePage();
    }
    else if ( text == 'All Songs' ){
      return AllSongs();
    }
    return PlayList();
  }
}




