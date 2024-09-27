import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  String caminhoBanco = join(await getDatabasesPath(), 'receitaav2.db');

  return openDatabase(
    caminhoBanco,
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE receitas (id INTEGER PRIMARY KEY, nome TEXT, image TEXT, modopreparo TEXT, ingredientes TEXT)');
    },
  );
}
