import 'package:flutter/material.dart';
import 'package:qr_reader_app/widgets/scan_tiles.dart';




class MapasScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ScanTiles(tipo: "geo");

  }
}