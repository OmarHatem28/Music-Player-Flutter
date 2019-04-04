import 'package:flutter/material.dart';
import 'database/DatabaseClient.dart';

class ScanSong extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScanSongState();

}

class ScanSongState extends State<ScanSong> {

  @override
  void initState() {
    super.initState();
//    bool inserted = runScan() as bool;
  }

  // TODO: make a radar (scan) get number of songs added or return total number
  Future<bool> runScan() async {
    return await DatabaseClient().insert();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scan For Songs"),
          elevation: 10.0,
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Text("Scanning :D"),
          ),
        ),
      ),
    );
  }



}