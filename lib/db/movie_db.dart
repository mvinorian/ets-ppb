import 'package:ets/model/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDB {
  static const _dbName = 'movie.db';

  static const moviesTable = 'movies';

  MovieDB._internal();
  static final MovieDB instance = MovieDB._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: 1, onCreate: _dbCreate);
  }

  Future _dbCreate(Database db, int version) async {
    const typeID = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const typeText = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $moviesTable (
  ${MovieField.id} $typeID,
  ${MovieField.title} $typeText,
  ${MovieField.description} $typeText,
  ${MovieField.createdAt} $typeText,
  ${MovieField.imageUrl} $typeText
)''');
  }

  Future<Movie> create(Movie movie) async {
    final db = await instance.database;
    final id = await db.insert(moviesTable, movie.toJson());
    return movie.copy(id: id);
  }

  Future<Movie> getById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      moviesTable,
      columns: MovieField.values,
      where: '${MovieField.id} = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Movie.fromJson(result.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Movie>> getAll() async {
    final db = await instance.database;
    final result = await db.query(
      moviesTable,
      orderBy: '${MovieField.createdAt} DESC',
    );

    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future update(Movie movie) async {
    final db = await instance.database;
    await db.update(
      moviesTable,
      movie.toJson(),
      where: '${MovieField.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future delete(int id) async {
    final db = await instance.database;
    await db.delete(
      moviesTable,
      where: '${MovieField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
