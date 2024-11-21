import 'package:flutter/cupertino.dart';
import 'dart:html' as html;

import 'package:image_picker_web/image_picker_web.dart';
import 'package:web_video_pick_show/src/web_video_pick_show_exception.dart';

extension UniqueFileIdentifier on html.File {
  String uniqueValue() {
    return "$name$lastModifiedDate";
  }
}

class WebVideoPickerController extends ChangeNotifier {
  List<html.File> _data = [];
  html.File? _currentlyPlaying;
  int _uniqueKey = 0;

  int get uniqueKey => _uniqueKey;

  List<html.File> get data => List.unmodifiable(_data);

  html.File? get currentVideoIfExits {
    final c = _currentlyPlaying;
    if (c == null) return null;
    final video =
        _data.where((e) => e.uniqueValue() == c.uniqueValue()).firstOrNull;
    return video;
  }

  void add(html.File newVideo) {
    _data = [..._data, newVideo];
    _uniqueKey++;
    notifyListeners();
  }

  bool isVideoPlaying(html.File selectedVideo) {
    return selectedVideo.uniqueValue() == _currentlyPlaying?.uniqueValue();
  }

  void addMany(List<html.File> newVideo) {
    _data = [..._data, ...newVideo];
    _uniqueKey++;
    notifyListeners();
  }

  void remove(int index) {
    final value = [..._data];
    value.removeAt(index);
    _data = value;
    _uniqueKey++;
    notifyListeners();
  }

  void clear() {
    _data = [];
    _uniqueKey++;
    notifyListeners();
  }

  void addRemoveManually(
      List<html.File> Function(List<html.File> initial) remove) {
    _data = remove([..._data]);
    _uniqueKey++;
    notifyListeners();
  }

  void play(html.File file) {
    _currentlyPlaying = file;
    _uniqueKey++;
    notifyListeners();
  }

  void pickVideo() async {
    try {
      final file = await ImagePickerWeb.getVideoAsFile();
      if (file == null) {
        throw WebVideoPickShowException(
          "Video not picked.",
          type: WebVideoPickShowExceptionType.noVideoPicked,
        );
      }
      add(file);
    } catch (e) {
      throw WebVideoPickShowException(
        e.toString(),
        type: WebVideoPickShowExceptionType.unknown,
      );
    }
  }

  void pickMultipleVideo() async {
    try {
      final file = await ImagePickerWeb.getMultiVideosAsFile();
      if (file == null) {
        throw WebVideoPickShowException(
          "Videos not picked.",
          type: WebVideoPickShowExceptionType.noVideoPicked,
        );
      }
      addMany(file);
    } catch (e) {
      throw WebVideoPickShowException(
        e.toString(),
        type: WebVideoPickShowExceptionType.unknown,
      );
    }
  }
}
