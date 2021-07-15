
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/screens/home_screen.dart';
import 'package:qr_reader_app/screens/mapa_screen.dart';
 
void main() => runApp(MyApp());

 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: "home",
        routes: {
          "home": (_) => HomeScreen(),
          "mapa": (_) => MapaScreen()
        },
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          ),
        ),
      ),
    );
  }
}