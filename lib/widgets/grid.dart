import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wordle/state/app_state.dart';

import '../constants/constants.dart';

class Grid extends StatelessWidget {
  final Map<int, List<String>> lines;
  final int currentLine;
  const Grid({
    Key? key,
    required this.lines,
    required this.gridSize,
    required this.currentLine,
  }) : super(key: key);

  final double gridSize;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    print(appState.letterStatuses);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(6, (colIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: colIndex != 6 ? 12 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (rowIndex) {
                String val = '';

                var b = lines[colIndex];

                if ((b?.length ?? 0) != 0 && rowIndex <= ((b?.length ?? 0) - 1)) val = (b![rowIndex]);

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: rowIndex != 5 ? 6 : 0),
                  width: gridSize,
                  height: gridSize,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: secondary),
                    color: colIndex < appState.currentLine ? getCellColor(context, rowIndex, val) : null,
                  ),
                  child: Center(
                    child: Text(
                      val.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Color? getCellColor(BuildContext context, int cellIndex, String cellValue) {
    final keywordArray = context.read<AppState>().keywordAsArray;

    //Harf, listede yok
    if (!keywordArray.contains(cellValue)) return null;

    //Harf, listede ve doğru yerde
    if (keywordArray[cellIndex] == cellValue) return Colors.green;

    //Harf, listede fakat farklı yerde
    if (keywordArray.contains(cellValue)) return Colors.amber.shade900;

    return null;
  }
}
