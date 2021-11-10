import 'package:flutter/material.dart';

void main() => runApp(CustomerApp());

class CustomerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: HomeView(),
      routes: {
        //'/homeView': (context) => HomeView(),
      },
    );
  }
}
