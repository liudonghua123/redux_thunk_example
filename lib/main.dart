
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'app.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'zh_CN']);

  runApp(LocalizedApp(delegate, App()));
}
