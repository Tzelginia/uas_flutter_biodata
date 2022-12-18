import 'dart:io';
import 'package:uas_flutter_biodata/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbHelper {
  final String databaseName = "biodata.db";
  final int databaseVersion = 3;

  // Atribut di Model User
  final String tabel_user = 'user';
  final String id = 'id';
  final String jk = 'jk';
  final String nim = 'nim';
  final String nama = 'nama';
  final String alamat = 'alamat';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    print('path loc : ' + path);
    print('database init');
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('terbuat');
    await db.execute(
        'CREATE TABLE ${tabel_user} ($id INTEGER PRIMARY KEY, $nim INTEGER, $nama TEXT NULL, $jk INTEGER,  $alamat TEXT NULL, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<User>> getAll() async {
    print('data all');
    final data = await _database!.query(tabel_user);
    List<User> result = data.map((e) => User.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    print('masuk');

    final query = await _database!.insert(tabel_user, row);
    return query;
  }

  Future<int> hapus(idUser) async {
    final query = await _database!
        .delete(tabel_user, where: '$id = ?', whereArgs: [idUser]);

    return query;
  }

  Future<int> update(int idUser, Map<String, dynamic> row) async {
    final query = await _database!
        .update(tabel_user, row, where: '$id = ?', whereArgs: [idUser]);
    return query;
  }
}
