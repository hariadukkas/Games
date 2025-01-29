import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'main.dart';

class ResultScreen extends StatelessWidget {


  void _playSound(bool won) async {
    // await _audioPlayer.play(AssetSource(won ? 'sounds/win.mp3' : 'sounds/lose.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context, listen: false);
    bool won = game.checkWin();
    _playSound(won);

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.purple.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  won ? '🎉 You Win!' : '❌ You Lose!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black38,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    game.resetGame();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: Text('Play Again', style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
