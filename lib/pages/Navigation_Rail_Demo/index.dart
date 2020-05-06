import 'package:flutter/material.dart';

class NavigationRailDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key key,
  }) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;
  double _minWidth = 80.0;

  bool _isHidden = false;

  void toggle() {
    setState(() {
      this._isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  NavigationRailTheme(
                    data: new NavigationRailThemeData(
                      backgroundColor: Colors.black,
                      unselectedIconTheme: new IconThemeData(
                        color: Colors.red,
                        size: 40.0,
                      ),
                      selectedIconTheme: new IconThemeData(
                        color: Colors.green,
                        size: 40.0,
                      ),
                      selectedLabelTextStyle: new TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                      unselectedLabelTextStyle: new TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                    child: NavigationRail(
                      backgroundColor: Colors.black,
                      trailing: Text("Trailing"),
                      leading: SafeArea(child: Container()),
                      extended: true, // only with NavigationRailLabelType.none
//                groupAlignment: 0.00001,
                      minExtendedWidth: 300.0,
                      minWidth: _minWidth,
                      elevation: 10,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.none,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite_border),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('First'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text('selectedIndex: $_selectedIndex'),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: _isHidden ? 0 : -630,
              child: Opacity(
                opacity: 0.9,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      RaisedButton(
                        elevation: 4,
                        onPressed: () {
                          toggle();
                        },
                        child: Text('Hello'),
                      ),
                      Text('minWidth prop'),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._minWidth = e;
                          });
                        },
                        min: 0.1,
                        max: 100.0,
                        value: _minWidth,
                      ),
                      Text('minWidth prop'),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._minWidth = e;
                          });
                        },
                        min: 0.1,
                        max: 100.0,
                        value: _minWidth,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
