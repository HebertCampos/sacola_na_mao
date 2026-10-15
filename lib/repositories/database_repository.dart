import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  static Database? db;

  Future<Database?> getDatabase() async{
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Future<Database?> iniciarBancoDeDados() async {
    try {
      db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, 
        onCreate:(Database db, int version) async {
          for (var i = 1; i <= scripts.length; i++){
            await db.execute(scripts[i]!);
            debugPrint(scripts[i]!);
          }
        },
        onUpgrade:(Database db, int oldVersion, int newVersion) async{
          for (var i = oldVersion + 1; i <= scripts.length; i++){
            await db.execute(scripts[i]!);
            debugPrint(scripts[i]!);
          }
        },
      );
      return db;
    } catch (e) {
      debugPrint('Erro ao iniciar banco de dados: $e');
      return null; 
    }
  }
}

Map<int, String> scripts = {
  1: ''' 
      CREATE TABLE produtos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        estoqueMinimo REAL NOT NULL,
        quantidade REAL NOT NULL,
        categoria TEXT NOT NULL
      );
   '''
};