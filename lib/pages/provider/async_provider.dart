import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Data with ChangeNotifier {
  bool loading = false;
  String data = '';

  void setNewData(String data) {
    this.data = data;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    this.loading = isLoading;
    notifyListeners();
  }
}

class AsyncProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(
          create: (_) => Data(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              color: Colors.blueGrey[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWidget(),
                    LoadButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (
        context,
        data,
        __,
      ) {
        if (data.data.length > 0 && !data.loading) {
          return Text(
            '${data.data}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          );
        }

        return Text(
          '${data.loading ? 'Something is loading' : ""}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 35,
          ),
        );
      },
    );
  }
}

class LoadButton extends StatelessWidget {
  void loadFakeData(Data data) async {
    data.setIsLoading(true);
    Future.delayed(const Duration(milliseconds: 2000), () {
      data.setIsLoading(false);
      data.setNewData("Hello world");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (
        context,
        data,
        __,
      ) {
        return RaisedButton(
          onPressed: () {
            loadFakeData(data);
          },
          child: data.loading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : Text(
                  'Download',
                  style: TextStyle(fontSize: 30),
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          padding: EdgeInsets.all(10),
        );
      },
    );
  }
}
