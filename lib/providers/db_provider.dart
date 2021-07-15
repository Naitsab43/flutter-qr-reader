
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader_app/models/scan_model.dart';

class DBProvider {


  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {

    if(_database != null) return _database;

    _database = await initDB();

    return _database;

  }

  Future<Database?> initDB() async {

    // Path de la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, "ScansDB.db");

    // Crear base de datos

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {

        await db.execute('''
          CREATE TABLE SCANS(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');

      }

    );

  }

  Future<int> nuevoScanRawvalor(ScanModel nuevoScan) async {

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar base de datos
    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO SCANS(id, tipo, valor) VALUES($id, "$tipo", "$valor")
    ''');

    return res;

  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db!.insert("Scans", nuevoScan.toMap() );

    return res;

  }

  Future<ScanModel?> getScanById(int i) async {

    final db = await database;

    final res = await db!.query("Scans", where: "id = ?", whereArgs: [i]);

    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;

  }

  Future<List<ScanModel>> getAllScans() async {

    final db = await database;

    final res = await db!.query("Scans");

    return res.isNotEmpty ? res.map((scan) => ScanModel.fromMap(scan)).toList() : [];

  }

  Future<List<ScanModel>> getScansByType(String tipo) async {

    final db = await database;

    final res = await db!.query("Scans", where: "tipo = ?", whereArgs: [tipo]);

    return res.isNotEmpty ? res.map((scan) => ScanModel.fromMap(scan)).toList() : [];

  }

  Future<int> updateScan(ScanModel nuevoScan) async {

    final db = await database;
    final res = await db!.update("Scans", nuevoScan.toMap(), where: "id = ?", whereArgs: [nuevoScan.id]);

    return res;

  }

  Future<int> deleteScan(int id) async {

    final db = await database;
    final res = await db!.delete("Scans", where: "id = ?", whereArgs: [id]);

    return res;

  }

  Future<int> deleteAllScans() async {

    final db = await database;
    final res = await db!.delete("Scans");

    return res;

  }


}