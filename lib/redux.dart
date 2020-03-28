import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

// AppState
class AppState {
  Locale locale;
  AppState({@required this.locale});
  @override
  String toString() {
    return 'AppState{locale: $locale}';
  }

  static initState() => AppState(locale: Locale('en', 'US'));
}

class LocaleAction {
  Locale locale;
  LocaleAction(this.locale);
  @override
  String toString() {
    return 'LocaleAction{locale: $locale}';
  }
}

// root reducer
AppState reducer(AppState prev, dynamic action) {
  return AppState(
    locale: localeReducer(prev.locale, action),
  );
}

// locale reducer
var localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, LocaleAction>(_localHandler),
]);

Locale _localHandler(Locale pre, LocaleAction action) {
  return action.locale;
}

Store<AppState> store = Store<AppState>(
  reducer,
  initialState: AppState.initState(),
  middleware: [thunkMiddleware, LoggingMiddleware.printer()],
);
