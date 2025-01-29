import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'result_screen.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Select Letters in Order')),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Tap letters in order:", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text(game.selectedAlphabets.join(" "), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
              itemCount: 100,
              itemBuilder: (context, index) {
                int row = index ~/ 10;
                int col = index % 10;
                String letter = game.grid[row][col];

                return GestureDetector(
                  onTap: () {
                    game.addSelectedLetter(letter);
                    if (game.selectedAlphabets.length == game.targetAlphabets.length) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultScreen()));
                    }
                  },
                  child: Card(
                    color: Colors.blue.shade100,
                    child: Center(
                      child: Text(letter, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
