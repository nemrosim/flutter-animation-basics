import 'package:flutter/material.dart';

void main() => runApp(NavigationRailDemo());

class NavigationRailDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({
    Key key,
  }) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int _selectedIndex = 0;

  /// The default is 72.
  /// To make a compact rail, set this to 56 and use
  double _minWidth = 72.0;

  /// The value must be between -1.0 and 1.0.
  ///
  /// If [groupAlignment] is -1.0, then the items are aligned to the top. If
  /// [groupAlignment] is 0.0, then the items are aligned to the center. If
  /// [groupAlignment] is 1.0, then the items are aligned to the bottom.
  ///
  /// The default is -1.0.
  double _groupAlignment = -1;
  double _minExtendedWidth = 300.0;
  double _elevation = 10.0;
  double _dividerThickness = 1;
  double _dividerWidth = 1;

  bool _isBottomHidden = true;

  void toggleBottomMenu() {
    setState(() {
      this._isBottomHidden = !_isBottomHidden;
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
                  CustomNavigationRailTheme(
                    child: NavigationRail(
                      backgroundColor: Colors.blueGrey[900],
                      trailing: Center(
                        child: Text(
                          "Trailing widget",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      leading: SafeArea(
                        bottom: false,
                        child: Center(
                          child: Text(
                            "Leading widget",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      labelType: NavigationRailLabelType.none,
                      extended: true, // only with NavigationRailLabelType.none
                      groupAlignment: _groupAlignment,
                      minExtendedWidth: _minExtendedWidth,
                      minWidth: _minWidth,
                      elevation: _elevation,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
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
                    color: Colors.blueGrey[900],
                    thickness: _dividerThickness,
                    width: _dividerWidth,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '$_selectedIndex',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: _isBottomHidden ? -630 : 0,
              child: Opacity(
                opacity: _isBottomHidden ? 0.2 : 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: 300,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            onPressed: () {
                              toggleBottomMenu();
                            },
                            child: Text(_isBottomHidden ? 'Show' : 'Hide'),
                          ),
                        ),
                      ),
                      SliderText(
                        text: 'Group alignment',
                        value: _groupAlignment,
                      ),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._groupAlignment = e;
                          });
                        },
                        min: -1,
                        max: 1,
                        value: _groupAlignment,
                      ),
                      SliderText(
                        text: 'Min Extended Width',
                        value: _minExtendedWidth,
                      ),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._minExtendedWidth = e;
                          });
                        },
                        min: 50.0,
                        max: 400.0,
                        value: _minExtendedWidth,
                      ),
                      SliderText(
                        text: 'Min Width',
                        value: _minWidth,
                      ),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._minWidth = e;
                          });
                        },
                        min: 0.1,
                        max: 200.0,
                        value: _minWidth,
                      ),
                      SliderText(
                        text: 'Divider thikness',
                        value: _dividerThickness,
                      ),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._dividerThickness = e;
                          });
                        },
                        min: 0.1,
                        max: 30.0,
                        value: _dividerThickness,
                      ),
                      SliderText(
                        text: 'Divider width',
                        value: _dividerWidth,
                      ),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._dividerWidth = e;
                          });
                        },
                        min: 0.1,
                        max: 30.0,
                        value: _dividerWidth,
                      ),
                      SliderText(
                        text: 'Elevation',
                        value: _elevation,
                      ),
                      Slider(
                        onChanged: (e) {
                          setState(() {
                            this._elevation = e;
                          });
                        },
                        min: 0.1,
                        max: 30.0,
                        value: _elevation,
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

class SliderText extends StatelessWidget {
  const SliderText({
    Key key,
    @required double value,
    @required String text,
  })  : _value = value,
        _text = text,
        super(key: key);

  final double _value;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_text ${_value.toStringAsPrecision(3)}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );
  }
}

class CustomNavigationRailTheme extends StatelessWidget {
  final Widget child;

  CustomNavigationRailTheme({this.child});

  @override
  Widget build(BuildContext context) {
    return NavigationRailTheme(
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
      child: child,
    );
  }
}
