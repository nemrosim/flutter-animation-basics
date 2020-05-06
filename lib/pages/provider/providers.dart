import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimpleStringData {
  String text;

  SimpleStringData({this.text});
}

class Data with DiagnosticableTreeMixin {
  bool loading = false;
  String data = '';
  String error = '';

  Data({this.loading, this.data, this.error});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('loading', loading));
    properties.add(StringProperty('data', data));
    properties.add(StringProperty('error', error));
  }
}
