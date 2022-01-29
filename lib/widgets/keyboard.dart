import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wordle/constants/constants.dart';
import 'package:wordle/state/app_state.dart';

import '../functions.dart';

class Keyboard extends StatefulWidget {
  final List<String> keys;

  const Keyboard({Key? key, required this.keys}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  List<String> word = [];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Expanded(
      child: Container(
        child: Column(
          children: List.generate(4, (index) {
            //Tile count in a row
            final int tileCount = 9;
            final int startRange = tileCount * index;
            final int endRange = index != 3 ? (tileCount * index) + tileCount : widget.keys.length;
            Widget child = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.keys.getRange(startRange, endRange).map((e) => _buildTile(appState, e)).toList(),
            );

            if (index == 3) {
              child = Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Material(
                        color: keyboardBg,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            if (word.length != 0) word.removeLast();
                            appState.updateLine(word);
                          },
                          child: Center(
                            child: Icon(Icons.backspace_outlined, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    flex: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.keys.getRange(startRange, endRange).map((e) => _buildTile(appState, e)).toList(),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Material(
                        color: keyboardBg,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            if (word.length == 5) appState.checkWord(word);
                            word = [];
                          },
                          child: Center(child: Icon(Icons.check, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Expanded(child: Column(children: [Expanded(child: child), if (index != 3) SizedBox(height: 6)]));
          }),
        ),
      ),
    );
  }

  Expanded _buildTile(AppState state, String e) {
    print(e);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        child: Material(
          borderRadius: BorderRadius.circular(4),
          color: tileBgColorByLetterStatus(state.getLetterStatus(e)),
          child: InkWell(
            onTap: () {
              if (word.length < 5) word.add(e);
              state.updateLine(word);
            },
            borderRadius: BorderRadius.circular(4),
            child: Center(
              child: Text('$e', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}
