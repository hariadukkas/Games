import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'result_screen.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Select Letters in Order')),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text("Tap letters in order:", style: TextStyle(fontSize: 18)),
          SizedBox(height: 5),
          Text(game.selectedAlphabets.join(" "), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: screenHeight * 0.6,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemCount: 25,
              itemBuilder: (context, index) {
                int row = index ~/ 5;
                int col = index % 5;
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
