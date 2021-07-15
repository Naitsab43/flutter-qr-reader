import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/screens/direcciones_screen.dart';
import 'package:qr_reader_app/screens/mapas_screen.dart';
import 'package:qr_reader_app/widgets/custom_navigationbar.dart';
import 'package:qr_reader_app/widgets/scan_button.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Historial"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => Provider.of<ScanListProvider>(context, listen: false).borrarTodos()
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}


class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(currentIndex){

      case 0:
      scanListProvider.cargarScanPorTipo("geo");
        return MapasScreen();

      case 1: 
        scanListProvider.cargarScanPorTipo("http");
        return DireccionesScreen();

      default:
        return MapasScreen();

    }

  }

}