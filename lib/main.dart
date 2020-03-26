import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk_example/page1.dart';
import './redux.dart';

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
                  'You have pushed times:\n$counter',
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                );
              },
            ),
            // display name and age
            StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                return Text(
                  'Extra info: name ${state.extra.name}, age: ${state.extra.age}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                );
              },
            ),
            // async get extra info
            FlatButton(
              color: Colors.lightBlue,
              onPressed: () async =>
                  StoreProvider.of<AppState>(context).dispatch(asyncAction),
              child: Text("do some async action"),
            ),
            // sync and async action
            FlatButton(
              color: Colors.lightBlue,
              onPressed: () async =>
                  StoreProvider.of<AppState>(context).dispatch(combineAction),
              child: Text("do some combine action"),
            ),
            // sync and async action
            FlatButton(
              color: Colors.lightBlue,
              onPressed: () async => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Page1())),
              child: Text("go to page2"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          StoreProvider.of<AppState>(context).dispatch(CounterAction(1));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
