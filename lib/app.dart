import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk_example/redux.dart';
import 'package:easy_localization/easy_localization.dart';

import 'home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (_, store) {
          // print('app, locale: ${store.state.locale}, title: ${tr('title')}');
          return MaterialApp(
            locale: store.state.locale,
            localizationsDelegates: [
              EasyLocalization.of(context).delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: EasyLocalization.of(context).supportedLocales,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
