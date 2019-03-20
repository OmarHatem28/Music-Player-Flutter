import 'package:flute_music_player/flute_music_player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  Song song;
  List<Song> _songs;
  Database _db;
  List<Map<String, dynamic>> records;
  int co = 0;

  Future createDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mySongs.db');

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Song (id INTEGER, title TEXT, duration NUMBER, albumArt TEXT, album TEXT, uri TEXT, artist TEXT, albumId NUMBER, isFav number NOT NULL default 0, count number not null default 0)');
    });

    //TODO: check for new songs added using size of current table and number of songs available
    records = await _db.query('Song');
    if (records.isEmpty) {
      bool flag = await insert();
      // if items are added to the DB
      if ( flag ){
        // fetch data from table again after insertion
        records = await _db.query('Song');
      }
    }

    return records;

  }

  Future<bool> insert() async {
    try {
      var songs = await MusicFinder.allSongs();
      songs = new List.from(songs);
      _songs = songs.cast<Song>();
    } catch (e) {
      print(e.toString());
    }
    try {
      await _db.transaction((txn) async {
        int myID;
        String query;
        for (Song song in _songs) {
          query =
              'INSERT INTO Song(id, title, duration, albumArt, album, uri, artist, albumId, isFav, count) '
              'VALUES(${song.id}, "${song.title}", ${song.duration}, "${song.albumArt}", "${song.album}", "${song.uri}", "${song.artist}", ${song.albumId}, 0, 0)';
          myID = await txn.rawInsert(query);
          co++;
        }
        print('inserted2: $myID');
      });
    } catch (e) {
      print("Error WarhiT " + e.toString());
      return false;
    }
    print("Passed WarhiT");
    if ( co > 0 )
      return true;
    else
      return false;
  }
}
