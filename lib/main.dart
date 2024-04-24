import 'package:flutter/material.dart';
import 'screens/loadingscreen.dart';

void main() =>runApp(const Myapp());

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark(),
      home: const LoadingScreen() ,
    );
  }
}
