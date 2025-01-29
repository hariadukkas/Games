import 'dart:math';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  List<String> targetAlphabets = [];
  List<String> selectedAlphabets = [];
  List<List<String>> grid = [];

  void generateAlphabets() {
    targetAlphabets = List.generate(10, (index) => _randomLetter());
    generateGrid();
    notifyListeners();
  }

  void generateGrid() {
    List<String> allLetters = List.generate(100, (index) => _randomLetter());
    for (int i = 0; i < 10; i++) {
      allLetters[i] = targetAlphabets[i];  // Ensure correct letters are present
    }
    allLetters.shuffle();
    grid = List.generate(10, (row) => allLetters.sublist(row * 10, (row + 1) * 10));
  }

  void addSelectedLetter(String letter) {
    if (selectedAlphabets.length < targetAlphabets.length) {
      selectedAlphabets.add(letter);
      notifyListeners();
    }
  }

  bool checkWin() {
    return selectedAlphabets.join() == targetAlphabets.join();
  }

  void resetGame() {
    selectedAlphabets = [];
    generateAlphabets();
    notifyListeners();
  }

  String _randomLetter() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return letters[Random().nextInt(letters.length)];
  }
}
