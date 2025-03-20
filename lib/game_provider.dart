import 'dart:math';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  List<String> targetAlphabets = [];
  List<String> selectedAlphabets = [];
  List<List<String>> grid = [];
  int numLetters=5;
  int numSeconds=5;
  DateTime? _startTime;
  DateTime? _endTime;

  void setStartTime() {
    _startTime = DateTime.now();
    _endTime = null;
  }

  Duration? getTotalTime() {
    if (_startTime != null && _endTime != null) {
      return _endTime!.difference(_startTime!);
    }
    return Duration();
  }



  void generateAlphabets() {
    targetAlphabets = List.generate(numLetters, (index) => _randomLetter());
    generateGrid();
    setStartTime();
    notifyListeners();
  }

  void generateGrid() {
    String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJ";
    List<String> allLetters = letters.split('')..shuffle();
    grid = List.generate(6, (row) => allLetters.sublist(row * 6, (row + 1) * 6));
  }

  void addSelectedLetter(String letter) {
    if (selectedAlphabets.length < targetAlphabets.length) {
      selectedAlphabets.add(letter);
      notifyListeners();
    }
  }

  bool checkWin() {
    _endTime = DateTime.now();
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

  void setGameSettings(int letters, int seconds) {
    numLetters = letters;
    numSeconds = seconds;
  }
}
