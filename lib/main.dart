import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmp/features/home/presentation/page/home.dart';
import 'package:wmp/shared/theme/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hapus label debug
      theme: ThemeData(
        brightness: themeNotifier.isDarkTheme ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
