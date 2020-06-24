import 'package:flutter/material.dart';
import 'package:paginated_list_app/src/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'paginated listview',
      home: HomeScreen(),
    );
  }
}
