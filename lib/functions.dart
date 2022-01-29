import 'package:flutter/material.dart';
import 'package:wordle/constants/letter_status_enum.dart';

import 'constants/constants.dart';

Color tileBgColorByLetterStatus(LetterStatus? status) {
  switch (status) {
    case LetterStatus.not_in_keyword:
      return secondary;
    case LetterStatus.in_keyword:
      return green;
    default:
      return keyboardBg;
  }
}
