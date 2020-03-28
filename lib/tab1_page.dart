import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:redux_thunk_example/redux.dart';

class Tab1Page extends StatelessWidget {
  const Tab1Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 0,
          ),
          child: ListTile(
            leading: Icon(Icons.language),
            title: Text(translate("language")),
            trailing: Icon(Icons.navigate_next),
            onTap: () async {
              // set up the list options
              var locales = [
                const Locale('en', 'US'),
                const Locale('zh', 'CN'),
              ];
              var selections = locales.map((locale) => SimpleDialogOption(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Container(child: Text(translate(locale.languageCode)))),
                  onPressed: () {
                    Navigator.of(context).pop(locale);
                  }));
              // set up the SimpleDialog
              SimpleDialog dialog = SimpleDialog(
                title: Text(translate('language')),
                children: <Widget>[
                  ...selections,
                ],
              );
              // show the dialog
              Locale locale = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return dialog;
                },
              );
              print('select locale: ${locale}');
              if (locale != null) {
                // EasyLocalization.of(context).locale = locale;
                StoreProvider.of<AppState>(context)
                    .dispatch(LocaleAction(locale));
                // Routes.router.navigateTo(context, Routes.home);
              }
            },
          ),
        ),
      ),
    );
  }
}
