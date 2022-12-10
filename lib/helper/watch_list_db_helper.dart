import 'package:imdb/model/watch_list_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WatchListDBHelper {
  static late Database _database;

  String tableName = "watchList";
  String columnId = "id";
  String columnImageUrl = "imageUrl";
  String columnImdbId = "imdbId";
  String columnMovieName = "movieName";
  String columnSummary = "summary";
  String columnGenres = "genres";
  String columnYoutubeId = "youtubeId";

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "watchList.db");
    Database watchListDB = await openDatabase(
      dbPath,
      version: 1,
      onCreate: createDb,
    );

    return watchListDB;
  }

  void createDb(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $tableName (
        $columnId integer primary key,
        $columnImageUrl text,
        $columnImdbId text,
        $columnMovieName text,
        $columnSummary text,
        $columnGenres text,
        $columnYoutubeId text
      )
    """);
  }

  Future<int> insertToWatchList(WatchListModel watchList) async {
    Database db = await database;

    int result = await db.insert(tableName, watchList.toJson());

    return result;
  }

  Future<int> deleteFromWatchList(String imdbId) async {
    Database db = await database;

    int result = await db.delete(
      tableName,
      where: "$columnImdbId=?",
      whereArgs: [imdbId],
    );

    return result;
  }

  Future<int> deleteWatchList() async {
    Database db = await database;

    int result = await db.delete(tableName);

    return result;
  }

  Future<List<WatchListModel>> getAllList() async {
    Database db = await database;

    var watchList = await db.query(tableName);

    return List.generate(watchList.length, (index) {
      return WatchListModel.fromJson(watchList[index]);
    });
  }

  Future<bool> isAdded(String imdbId) async {
    Database db = await database;

    var result = await db.query(
      tableName,
      where: "$columnImdbId=?",
      whereArgs: [imdbId],
    );

    if (result.isNotEmpty) {
      return true;
    }

    return false;
  }
}
