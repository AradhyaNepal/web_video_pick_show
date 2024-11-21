// Alternative Ways

//#1
//Original Source: https://github.com/sawin0/video_player_web/

// import 'dart:html' as html;
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class LocalVideoPlayerWeb extends StatefulWidget {
//   const LocalVideoPlayerWeb({Key? key}) : super(key: key);
//
//   @override
//   _LocalVideoPlayerWebState createState() => _LocalVideoPlayerWebState();
// }
//
// class _LocalVideoPlayerWebState extends State<LocalVideoPlayerWeb> {
//   VideoPlayerController? _controller;
//   String? _videoPath;
//
//   Future<void> _pickVideo() async {
//     // Use HTML file input for web file selection
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'video/*';
//     uploadInput.click();
//
//     uploadInput.onChange.listen((event) async {
//       final file = uploadInput.files!.first;
//       final reader = html.FileReader();
//
//       reader.onLoadEnd.listen((event) {
//         try {
//           // Convert result to Uint8List if it's not already
//           Uint8List videoData;
//           if (reader.result is Uint8List) {
//             videoData = reader.result as Uint8List;
//           } else if (reader.result is List<int>) {
//             videoData = Uint8List.fromList(reader.result as List<int>);
//           } else {
//             throw Exception('Unsupported file data type');
//           }
//
//           // Create a blob from Uint8List
//           final blob = html.Blob([videoData], file.type);
//           final videoUrl = html.Url.createObjectUrlFromBlob(blob);
//
//           setState(() {
//             _videoPath = videoUrl;
//             _controller = VideoPlayerController.network(videoUrl)
//               ..initialize().then((_) {
//                 setState(() {});
//                 _controller!.play();
//               }).catchError((error) {
//                 print('Video initialization error: $error');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error loading video: $error')),
//                 );
//               });
//           });
//         } catch (e) {
//           print('Error processing video file: $e');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error processing video: $e')),
//           );
//         }
//       });
//
//       reader.onError.listen((error) {
//         print('File reading error: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error reading file: $error')),
//         );
//       });
//
//       // Read the file as an array buffer
//       reader.readAsArrayBuffer(file);
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Local Video Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Video Player
//             if (_controller != null && _controller!.value.isInitialized)
//               AspectRatio(
//                 aspectRatio: _controller!.value.aspectRatio,
//                 child: VideoPlayer(_controller!),
//               ),
//
//             // Video Controls
//             if (_controller != null)
//               VideoProgressIndicator(
//                 _controller!,
//                 allowScrubbing: true,
//                 // colors: const VideoProgressIndicatorColors(
//                 // playedColor: Colors.red,
//                 // bufferedColor: Colors.grey,
//                 // ),
//               ),
//
//             // Pick Video Button
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: const Text('Select Video'),
//             ),
//
//             // Playback Controls
//             if (_controller != null)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(_controller!.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow),
//                     onPressed: () {
//                       setState(() {
//                         _controller!.value.isPlaying
//                             ? _controller!.pause()
//                             : _controller!.play();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//#2: Modification on same upper code
//
// void main(){
//   final html.FileUploadInputElement uploadInput =
//   html.FileUploadInputElement()..accept = 'video/*';
//   uploadInput.click();
//
//   uploadInput.onChange.listen((event) async {
//     final files = uploadInput.files;
//
//     if (files != null && files.isNotEmpty) {
//       final html.File videoFile = files.first;
//
//       // Read the file as a Blob
//       final reader = html.FileReader();
//
//       reader.onLoadEnd.listen((event) {
//         try {
//           final Uint8List videoBytes = reader.result as Uint8List;
//           final fileName =
//               '${Uuid().v1()}_${_projectMorbidityQuestion.projectMorbidityQuestionId}.mp4';
//
//           // Check file size
//           if (_isFileSizeValid(videoBytes)) {
//             _processValidVideoFile(fileName, videoBytes);
//           } else {
//             _handleInvalidFileSize();
//           }
//         } catch (e) {
//           _handleError('Error processing video file: $e');
//         }
//       });
//
//       reader.onError.listen((error) {
//         _handleError('Error reading video file: $error');
//       });
//
//       // Read the file as an array buffer
//       reader.readAsArrayBuffer(videoFile);
//     }
//   });
// }
// }
