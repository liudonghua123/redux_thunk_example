import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localized_app.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk_example/demo.dart';
import 'package:redux_thunk_example/redux.dart';

import 'home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (_, store) {
          print(
              'app, locale: ${store.state.locale}, title: ${translate('title')}');
          return MaterialApp(
            locale: store.state.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DemoLocalizationsDelegate(),
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
