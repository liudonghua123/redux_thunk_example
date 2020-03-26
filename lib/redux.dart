import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

// AppState
class AppState {
  int counter;
  Extra extra;
  AppState({this.counter, this.extra});
  @override
  String toString() {
    return 'AppState{counter: $counter, extra: $extra}';
  }
}

class Extra {
  final String name;
  final int age;
  Extra(this.name, this.age);
  @override
  String toString() {
    return 'Extra{counter: $name, extra: $age}';
  }
}

// actions
class CounterAction {
  int adder = 1;
  CounterAction(this.adder);
  @override
  String toString() {
    return 'CounterAction{adder: $adder}';
  }
}

class ExtraAction {
  Extra extra;
  ExtraAction(this.extra);
  @override
  String toString() {
    return 'ExtraAction{extra: $extra}';
  }
}

// ThunkAction
ThunkAction<AppState> asyncAction = (Store<AppState> store) async {
  await Future.delayed(Duration(seconds: 3));
  store.dispatch(ExtraAction(Extra('Eric', 18)));
};
ThunkAction<AppState> combineAction = (Store<AppState> store) async {
  store.dispatch(CounterAction(3));
  await Future.delayed(Duration(seconds: 3));
  store.dispatch(ExtraAction(Extra('John', 21)));
};

// root reducer
AppState reducer(AppState prev, dynamic action) {
  return AppState(
    counter: counterReducer(prev.counter, action),
    extra: extraReducer(prev.extra, action),
  );
}

// counter reducer
var counterReducer = combineReducers<int>([
  TypedReducer<int, CounterAction>(_counterHandler),
]);

int _counterHandler(int pre, CounterAction action) {
  return pre + action.adder;
}

// extra reducer
var extraReducer = combineReducers<Extra>([
  TypedReducer<Extra, ExtraAction>(_extraHandler),
]);

Extra _extraHandler(Extra pre, ExtraAction action) {
  return action.extra;
}
