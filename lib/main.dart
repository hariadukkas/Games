import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'memory_screen.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _numLetters = 10;
  double _numSeconds = 5;

  @override
  Widget build(BuildContext context) {
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
                  'Alphabet Memory Game',
                  style: TextStyle(
                    fontSize: 32,
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
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

                // Slider for Number of Letters
                Text(
                  'Number of Letters: ${_numLetters.toInt()}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Slider(
                  value: _numLetters,
                  min: 5,
                  max: 20,
                  divisions: 15,
                  label: _numLetters.toInt().toString(),
                  onChanged: (value) {
                    setState(() {
                      _numLetters = value;
                    });
                  },
                ),

                // Slider for Number of Seconds
                Text(
                  'Memorization Time: ${_numSeconds.toInt()} sec',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Slider(
                  value: _numSeconds,
                  min: 3,
                  max: 10,
                  divisions: 7,
                  label: _numSeconds.toInt().toString(),
                  onChanged: (value) {
                    setState(() {
                      _numSeconds = value;
                    });
                  },
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black,
                    elevation: 8,
                  ),
                  onPressed: () {
                    Provider.of<GameProvider>(context, listen: false).setGameSettings(_numLetters.toInt(), _numSeconds.toInt());
                    Provider.of<GameProvider>(context, listen: false).generateAlphabets();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MemoryScreen()),
                    );
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
