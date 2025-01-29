import 'dart:math';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  List<String> targetAlphabets = [];
  List<String> selectedAlphabets = [];
  List<List<String>> grid = [];

  void generateAlphabets() {
    targetAlphabets = List.generate(5, (index) => _randomLetter());
    generateGrid();
    notifyListeners();
  }

  void generateGrid() {
    int position;
    Set<int> usedPositions = {};
    List<String> allLetters = List.generate(25, (index) => _randomLetter());
    for (int i = 0; i < 5; i++) {
      do {
        position = Random().nextInt(25);
      } while (usedPositions.contains(position));
      allLetters[position] = targetAlphabets[i];  // Ensure correct letters are present
    }
    grid = List.generate(5, (row) => allLetters.sublist(row * 5, (row + 1) * 5));
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
