//see: https://github.com/sawin0/video_player_web/

// or
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