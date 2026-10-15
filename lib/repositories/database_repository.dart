import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as path;

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
      // Garantia extra de inicialização caso o main() não tenha sido suficiente
      // ignore: unnecessary_null_comparison
      if (databaseFactory == null) {
        if (kIsWeb) {
          databaseFactory = databaseFactoryFfiWeb;
        } else {
          databaseFactory = databaseFactoryFfi;
        }
      }

      var db = await openDatabase(
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