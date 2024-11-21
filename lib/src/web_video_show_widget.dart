import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:web_video_pick_show/src/web_video_picker_controller.dart';

class EasyWebVideoShowWidget extends StatelessWidget {
  final WebVideoPickerController controller;
  final double? height;
  final double? width;
  final Widget Function()? noItemBuilder;
  ///Might set
  ///
  /// ..controls = true
  ///
  /// ..muted = true
  ///
  /// ..autoplay = true
  final html.VideoElement? customSettings;

  const EasyWebVideoShowWidget({
    super.key,
    required this.controller,
    this.noItemBuilder,
    this.height,
    this.width,
    this.customSettings,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final currentVideo = controller.currentVideoIfExits;
        if (currentVideo == null) {
          return noItemBuilder?.call() ?? const SizedBox();
        }
        return CustomWebVideoShowWidget(
          height: height,
          width: width,
          uniqueKey: ValueKey(currentVideo.uniqueValue()),
          file: currentVideo,
          customSettings: customSettings,
        );
      },
    );
  }
}

class CustomWebVideoShowWidget extends StatefulWidget {
  final html.File file;

  ///This key is necessary to rebuild the widget when the value is changed.
  ///
  /// Lets say you selected Video 1, and now want to play Video 2.
  /// Without this key flutter might try to reuse the widget.
  final Key uniqueKey;
  final double? height;
  final double? width;
  final html.VideoElement? customSettings;

  const CustomWebVideoShowWidget({
    required this.uniqueKey,
    required this.file,
    this.height,
    this.width,
    this.customSettings,
  }) : super(key: uniqueKey);

  @override
  State<CustomWebVideoShowWidget> createState() => _CustomWebVideoShowWidgetState();
}

class _CustomWebVideoShowWidgetState extends State<CustomWebVideoShowWidget> {
  String? videoUrl;
  String? viewType;

  @override
  void initState() {
    super.initState();

    viewType = 'videoElement${DateTime.now().millisecondsSinceEpoch}';

    videoUrl = html.Url.createObjectUrl(widget.file);

    final videoElement = (widget.customSettings ??
        (html.VideoElement()
          ..controls = true
          ..muted = true
          ..autoplay = true))
      ..src = videoUrl ?? "";

    ui.platformViewRegistry.registerViewFactory(
      viewType ?? "-",
      (int viewId) => videoElement,
    );
  }

  @override
  void dispose() {
    if (videoUrl != null) {
      html.Url.revokeObjectUrl(videoUrl ?? "-");
      videoUrl = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 300,
      width: widget.width ?? 300,
      child: HtmlElementView(viewType: viewType ?? "-"),
    );
  }
}
