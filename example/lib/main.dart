import 'dart:developer';

import 'package:example/show_custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:web_video_pick_show/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = WebVideoPickerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            WebVideoPickerButton(
              controller: _controller,
            ),
            WebVideoPickedItemCard(
              controller: _controller,
            ),
            EasyWebVideoShowWidget(
              controller: _controller,
            ),
            //Or If you are only using this package to show,
            // you are picking from something else
            // CustomWebVideoShowWidget(
            //   uniqueKey: ValueKey(someUniqueValueToDifferentiateTwoFile),
            //   file: fileWhichMightBePickedFromSomeOtherSource,
            // ),
          ],
        ),
      )),
    );
  }
}

class WebVideoPickerButton extends StatelessWidget {
  final WebVideoPickerController controller;

  const WebVideoPickerButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            _handleException(context,()async{
              await controller.pickVideo();
            });
          },
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            _handleException(context,()async{
              await controller.pickMultipleVideo();
            });

          },
          child: const Text("Add Multiple"),
        ),
      ],
    );
  }

  void _handleException(BuildContext context,Future<void> Function() action)async{
    final scaffold = ScaffoldMessenger.of(context);
    try {
      await action();
    } on WebVideoPickShowException catch (e, s) {
      if(e.type==WebVideoPickShowExceptionType.noVideoPicked)return;
      scaffold.showSnackBar(errorSnackBar(e.toString()));
      // scaffold.showSnackBar(errorSnackBar(e.withoutOppsie()));
      log(s.toString());
    } catch (e, s) {
      scaffold.showSnackBar(errorSnackBar(e.toString()));
      log(s.toString());
    }
  }
}

class WebVideoPickedItemCard extends StatelessWidget {
  final WebVideoPickerController controller;

  const WebVideoPickedItemCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final data = controller.data;
        return Row(
          key: ValueKey(controller.data),
          children: [
            for (int i = 0; i < data.length; i++)
              Builder(builder: (context) {
                final isPlaying = controller.isVideoPlaying(data[i]);
                return Container(
                  color: Colors.red,
                  margin: const EdgeInsets.only(left: 20),
                  height: 250,
                  width: 250,
                  child: Column(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          controller.remove(i);
                        },
                        child: const Text("Delete"),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          if (isPlaying) return;
                          controller.play(data[i]);
                        },
                        child: Text(isPlaying ? "Is Playing" : "Play"),
                      ),
                      const Spacer(),
                      Text(data[i].name),
                      const Spacer(),
                    ],
                  ),
                );
              })
          ],
        );
      },
    );
  }
}
