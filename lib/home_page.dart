import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_translate/global.dart';
import 'package:redux_thunk_example/redux.dart';

import 'tab1_page.dart';
import 'tab2_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Locale>(
      converter: (store) => store.state.locale,
      builder: (_, locale) {
        print('home build, locale: ${locale}, title: ${translate('title')}');
        return Scaffold(
          appBar: AppBar(title: Text(translate('title'))),
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                Tab1Page(),
                Tab2Page(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text(translate('tab1'))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), title: Text(translate('tab2'))),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
          ),
        );
      },
    );
  }
}
