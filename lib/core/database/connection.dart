import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:booklog/core/database/scripts/book_script.dart';


class Connection {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) {
      return _db!;
    }

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
      }

      final String path = join(await getDatabasesPath(), 'booklog.db');

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          final batch = db.batch();
          for (var comando in createTables) {
            batch.execute(comando);
          }
          for (var comando in insertBooks) {
            batch.execute(comando);
          }
          await batch.commit(noResult: true);
        },
      );
      return _db!;
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }
}