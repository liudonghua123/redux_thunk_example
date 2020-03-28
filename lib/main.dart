import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:redux_thunk_example/translate_preferences.dart';

import 'app.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US', 'zh_CN'],
    preferences: TranslatePreferences(),
  );

  runApp(LocalizedApp(delegate, App()));
}
