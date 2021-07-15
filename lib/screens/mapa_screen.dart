import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapaScreen extends StatefulWidget {

  @override
  _MapaScreenState createState() => _MapaScreenState();

}

class _MapaScreenState extends State<MapaScreen> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 19,
      tilt: 20.5
    );

    // Marcadores

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId("geo-location"),
      position: scan.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
        actions: [
          IconButton(
            icon: Icon(Icons.track_changes_outlined),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: scan.getLatLng(),
                zoom: 19,
                tilt: 20.5
              )));
            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: (){

          if(mapType == MapType.normal){
            setState(() {
              mapType = MapType.hybrid;
            });
          }
          else{
            setState(() {
              mapType = MapType.normal;
            });
          }

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
   );
  }
}