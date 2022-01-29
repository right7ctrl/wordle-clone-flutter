import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wordle/constants/constants.dart';
import 'package:wordle/state/app_state.dart';
import 'package:wordle/widgets/app_bar.dart';
import 'package:wordle/widgets/grid.dart';
import 'package:wordle/widgets/keyboard.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final gridSize = ((MediaQuery.of(context).size.width - 40) / 6).roundToDouble();

    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WordleAppbar(),
            Container(
              height: 1,
              color: secondary,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 12),
            ),
            Grid(gridSize: gridSize, lines: appState.lines, currentLine: appState.currentLine),
            Keyboard(
              keys: keys,
            ),
          ],
        ),
      ),
    );
  }
}
