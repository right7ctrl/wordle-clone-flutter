import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wordle/constants/constants.dart';

class WordleAppbar extends StatelessWidget {
  const WordleAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.help_outline, color: secondary)),
            //Used for align center title only.
            IconButton(onPressed: null, icon: Icon(Icons.help_outline, color: primary)),
          ],
        ),
        Expanded(
            child: Text(
          "WORDLE",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        )),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.help_outline, color: secondary)),
            IconButton(onPressed: () {}, icon: Icon(Icons.help_outline, color: secondary)),
          ],
        ),
      ],
    );
  }
}
