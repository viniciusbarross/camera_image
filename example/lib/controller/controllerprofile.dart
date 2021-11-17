import 'dart:io';

import 'package:flutter/cupertino.dart';

class ControllerProfile extends ChangeNotifier {
  File _image;

  File get image => this._image;

  set image(File value) {
    this._image = value;
    notifyListeners();
  }
}
