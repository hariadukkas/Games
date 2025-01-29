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
          Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Select Letters in Order",
                style: TextStyle(
                  fontSize: 28, // Slightly smaller text
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
              SizedBox(height: 10),
              Text(
                "Tap letters in order:",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                game.selectedAlphabets.join(" "),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: screenHeight * 0.80, // Slightly smaller height
                child: GridView.builder(
                  padding: EdgeInsets.all(5), // Reduce padding
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 4, // Reduce spacing
                    mainAxisSpacing: 4, // Reduce spacing
                    childAspectRatio: 1.2, // Adjust size ratio (Increase for smaller squares)
                  ),
                  itemCount: 36,
                  itemBuilder: (context, index) {
                    int row = index ~/ 6;
                    int col = index % 6;
                    String letter = game.grid[row][col];

                    return GestureDetector(
                      onTap: () {
                        game.addSelectedLetter(letter);
                        if (game.selectedAlphabets.length == game.targetAlphabets.length) {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (_) => ResultScreen()));
                        }
                      },
                      child: Card(
                        color: Colors.deepPurpleAccent.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Reduce corner radius
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: 20, // Slightly smaller font size
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
