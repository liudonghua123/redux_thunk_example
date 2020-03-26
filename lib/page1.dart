import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk_example/redux.dart';

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) => Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text('counter: ${state.counter}'),
                ),
                RaisedButton(
                  onPressed: () async => Navigator.of(context).pop(),
                  child: Text("back"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var _store = StoreProvider.of<AppState>(context);
          print(_store);
          _store.dispatch(CounterAction(1));
        },
        tooltip: 'Increment 2',
        child: Icon(Icons.add),
      ),
    );
  }
}
