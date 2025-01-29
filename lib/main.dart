import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'memory_screen.dart';
import 'game_screen.dart';

void main() {
  runApp(MyGameApp());
}

class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Memory Game',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alphabet Memory Game')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<GameProvider>(context, listen: false).generateAlphabets();
            Navigator.push(context, MaterialPageRoute(builder: (_) => MemoryScreen()));
          },
          child: Text('Play', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
