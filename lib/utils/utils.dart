import 'package:qr_reader_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

launchURL(BuildContext context, ScanModel scan) async {

  final url = scan.valor;

  if(scan.tipo == "http"){

    if (await canLaunch(url)){
      await launch(url);
    }
    else {
      throw "$url";
    }
  }
  else {
    Navigator.pushNamed(context, "mapa", arguments: scan);
  }

}