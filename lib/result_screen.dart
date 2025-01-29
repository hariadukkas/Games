import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'main.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context, listen: false);
    bool won = game.checkWin();

    return Scaffold(
      appBar: AppBar(title: Text(won ? 'You Win!' : 'You Lose!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(won ? '🎉 You Win!' : '❌ You Lose!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.resetGame();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              child: Text('Play Again', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
