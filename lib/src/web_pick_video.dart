import 'package:image_picker_web/image_picker_web.dart';
import 'package:web_video_pick_show/src/web_video_pick_show_controller.dart';
import 'package:web_video_pick_show/src/web_video_pick_show_exception.dart';

void pickVideo(WebVideoPickShowController controller) async {
  try {
    final file = await ImagePickerWeb.getVideoAsFile();
    if (file == null) {
      throw WebVideoPickShowException(
        "Video not picked.",
        type: WebVideoPickShowExceptionType.noVideoPicked,
      );
    }
    controller.add(file);
  } catch (e) {
    throw WebVideoPickShowException(
      e.toString(),
      type: WebVideoPickShowExceptionType.unknown,
    );
  }
}

void pickMultipleVideo(WebVideoPickShowController controller) async {
  try {
    final file = await ImagePickerWeb.getMultiVideosAsFile();
    if (file == null) {
      throw WebVideoPickShowException(
        "Videos not picked.",
        type: WebVideoPickShowExceptionType.noVideoPicked,
      );
    }
    controller.addMany(file);
  } catch (e) {
    throw WebVideoPickShowException(
      e.toString(),
      type: WebVideoPickShowExceptionType.unknown,
    );
  }
}
