import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmp/shared/theme/theme_notifier.dart';

class ButtonThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    
    return FloatingActionButton(
      onPressed: () {
        themeNotifier.toggleTheme();
      },
      backgroundColor: Colors.grey,
      mini: true,
      child: Icon(
        themeNotifier.isDarkTheme 
            ? Icons.dark_mode 
            : Icons.light_mode,
      ),
    );
  }
}