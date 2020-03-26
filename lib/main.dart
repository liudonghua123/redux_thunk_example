import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import './redux.dart';

// store that hold our current appstate
final store = Store<AppState>(reducer,
    initialState: AppState(counter: 0, extra: Extra('Lily', 0)),
    middleware: [thunkMiddleware, LoggingMiddleware.printer()]);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreConnector<AppState, int>(
              converter: (store) => store.state.counter,
              builder: (_, counter) {
                return Text(
                  'You have pushed the button this many times:\n$counter',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),

            // display name and age
            StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                return Text(
                  ' ${state.extra.name} \n -${state.extra.age}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                );
              },
            ),

            // async get extra info
            StoreConnector<AppState, AsyncCallback>(
              converter: (store) => () async => store.dispatch(asyncAction),
              builder: (_, asyncCallback) {
                return FlatButton(
                    color: Colors.lightBlue,
                    onPressed: asyncCallback,
                    child: Text("do some async action"));
              },
            ),
            // sync and async action
            StoreConnector<AppState, AsyncCallback>(
              converter: (store) => () async => store.dispatch(combineAction),
              builder: (_, asyncCallback) {
                return FlatButton(
                    color: Colors.lightBlue,
                    onPressed: asyncCallback,
                    child: Text("do some combine action"));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, IncrementCounter>(
        converter: (store) => () => store.dispatch(CounterAction(1)),
        builder: (_, incrementCallback) {
          return FloatingActionButton(
            onPressed: incrementCallback,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

typedef void IncrementCounter(); // This is sync.
typedef Future<void> AsyncCallback(); // This is async.
