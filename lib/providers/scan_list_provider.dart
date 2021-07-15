

import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:qr_reader_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String tipoSeleccionado = "http";

  Future<ScanModel> nuevoScan(String valor) async {

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;
    
    if(this.tipoSeleccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;

  }
  
  cargarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansByType(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    this.cargarScanPorTipo(this.tipoSeleccionado);
    notifyListeners();
  }

}