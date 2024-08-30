import 'package:receitas/database/db.dart';
import 'package:receitas/model/receita.dart';
import 'package:sqflite/sqflite.dart';

// Método para inserir uma receita
Future<int> insertReceita(Receita receita) async {
  Database db = await getDatabase();
  return db.insert('receitas', receita.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// Método para buscar todas as receitas
Future<List<Receita>> findAll() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> data = await db.query('receitas');
  return List.generate(data.length, (i) {
    return Receita.fromMap(data[i]);
  });
}

// Método para buscar uma receita específica pelo ID
Future<Receita?> findReceitaById(int id) async {
  final Database db = await getDatabase();

  List<Map<String, dynamic>> maps = await db.query(
    'receitas',
    where: 'id = ?',
    whereArgs: [id],
  );

  if (maps.isNotEmpty) {
    return Receita.fromMap(maps.first);
  } else {
    return null; // Retorna null se a receita não for encontrada
  }
}
