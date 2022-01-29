import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wordle/constants/constants.dart';
import 'package:wordle/constants/letter_status_enum.dart';

import '../main.dart';

class AppState with ChangeNotifier {
  GlobalKey materialAppKey = GlobalKey();
  late Map<int, List<String>> lines;
  late int currentLine;

  late String keyword;
  List<String> get keywordAsArray => keyword.split('');

  Map<String, LetterStatus> letterStatuses = {};

  initApp({bool updateState = false}) {
    resetState();
    keyword = keywords.elementAt(Random().nextInt(keywords.length));
    print(keyword);
    if (updateState) notifyListeners();
  }

  resetState() {
    letterStatuses = {};
    keyword = '';
    currentLine = 0;
    lines = {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
    };
  }

  //Sonraki satır
  nextLine() {
    currentLine++;
    notifyListeners();
  }

  checkWord(List<String> word) {
    //Eğer girilen kelime, kelime listesinde
    if (!keywords.contains(word.join(''))) return;

    updateLine(word);

    ///Bu satır için tahmin yapıldı, doğru mu diye kontrol ediyoruz
    if (keyword == (word.join(''))) {
      Get.defaultDialog(
        title: 'Tebrikler',
        middleText: 'Tekrar oynamaya ne dersin?',
        actions: [
          IconButton(
            onPressed: () {
              initApp(updateState: true);
              Get.back();
            },
            icon: Icon(Icons.replay),
          ),
        ],
      );
      nextLine();
      return;
    }
    addOrUpdateLetterStatus(word);

    nextLine();
  }

  updateLine(List<String> word) {
    //Son satırdaysak, devam etme
    if (currentLine == 5) return;
    lines[currentLine] = word;
    notifyListeners();
  }

  void addOrUpdateLetterStatus(List<String> word) {
    for (var i = 0; i < keywordAsArray.length - 6; i++) {
      if (letterStatuses.containsKey(word[i])) return;
      if (word[i] == keywordAsArray[i]) {
        letterStatuses[word[i]] = LetterStatus.in_keyword;
      } else if (keywordAsArray.contains(word[i])) {
        letterStatuses[word[i]] = LetterStatus.not_in_correct_index;
      } else {
        letterStatuses[word[i]] = LetterStatus.not_in_keyword;
      }
      notifyListeners();
    }
  }

  LetterStatus? getLetterStatus(String letter) {
    if (!letterStatuses.containsKey(letter)) return null;
    print(letter);
    return letterStatuses[letter];
  }

  void replay() {
    Get.rootController.restartApp();
  }
}
