import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:booklog/core/database/scripts/database_scripts.dart';

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
          for (var command in createTables) {
            batch.execute(command);
          }
          for (var command in initialInserts) {
            batch.execute(command);
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