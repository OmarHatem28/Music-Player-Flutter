import 'package:flutter/material.dart';
import 'package:music_player/allSongs.dart';

class LocalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocalPageState();
}

class LocalPageState extends State<LocalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
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
            )
          ),
          Expanded(
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
