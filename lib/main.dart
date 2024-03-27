import 'package:flutter/material.dart';
import 'package:lista_de_compras/page/home_page.dart';

void main() => runApp( MyApp());

class MyApp extends MaterialApp {
  MyApp({super.key}) : super(
  debugShowCheckedModeBanner: false,
  home:  HomePage(),
  theme: ThemeData(brightness: Brightness.dark)
  );
}
