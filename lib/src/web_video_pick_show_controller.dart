import 'package:flutter/cupertino.dart';
import 'dart:html' as html;

///Throws exception if used in android apps
class WebVideoPickShowController extends ChangeNotifier {
  List<html.File> _data = [];
  html.File? _currentlyPlaying;

  List<html.File> get data => List.unmodifiable(_data);

  html.File? get currentVideo {
    return _currentlyPlaying;
  }

  void add(html.File newVideo) {
    _data = [..._data, newVideo];
    notifyListeners();
  }

  void addMany(List<html.File> newVideo) {
    _data = [..._data, ...newVideo];
    notifyListeners();
  }

  void remove(int index) {
    final value = [..._data];
    value.removeAt(index);
    _data = value;
    notifyListeners();
  }

  void play(html.File file) {
    _currentlyPlaying = file;
    notifyListeners();
  }
}
