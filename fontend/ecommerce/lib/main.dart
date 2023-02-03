import 'package:flutter/material.dart';
import 'directory/home/main_goods_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home-Pages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainGoodPage(),
    );
  }
}
