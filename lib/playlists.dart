import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlayListState();
}

class PlayListState extends State<PlayList> {

  List<Widget> myWidget = [
    GestureDetector(
      child: Container(
        height: 150,
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/music_cover.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text("All Songs"),
            trailing: Icon(
              Icons.queue_music,
              color: Colors.white,
            ),
          ),
        ),
        margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
      ),
      onTap: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => AllSongs() ));
      },
    ),
    GestureDetector(
      child: Container(
        height: 150,
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/music_cover2.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text("Favorites"),
            trailing: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        ),
        margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
      ),
      onTap: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => AllSongs() ));
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: _buildPlaylists()),
      ],
    );
  }

  Widget _buildPlaylists() {
    return ListView.builder(
        itemCount: myWidget.length*2,
        itemBuilder: (context, int i) {
          return myWidget[i%2];
        });
  }
}
