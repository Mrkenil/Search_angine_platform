import 'package:flutter/material.dart';
import 'package:search_engine_platform/views/screens/search_angine_page.dart';
import 'package:search_engine_platform/views/screens/select_search_angine_page.dart';

void main() {
  runApp(
    app(),
  );
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => select_search_angine_page(),
        'search_page': (context) => search_angine_page(),
      },
    );
  }
}
