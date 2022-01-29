import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:wordle/state/app_state.dart';
import 'package:wordle/views/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    context.read<AppState>().initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AppState>();

    return GetMaterialApp(
      key: p.materialAppKey,
      home: const HomeView(),
    );
  }
}
