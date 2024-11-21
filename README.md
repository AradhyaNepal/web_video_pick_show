# web_video_pick_show

This package can be used to pick and view video in web.

### Warning: Works only for Web

For picking this package uses image_picker_web internally, so for picking you can use on your own
way.

For showing, you can use EasyWebVideoShowWidget() if you have picked from this package.
If you have picked on your own way, you can use CustomWebVideoShowWidget().

I recommend you seeing the repository instead of the code, so that you can customize on your own
way.
Also because this package is on beta phase and I don't got enough time for dedication on this
package,
yet you can send pull request and issues are appreciated, I will try my best to work on them.
[Repository](https://github.com/AradhyaNepal/web_video_pick_show)

You can also see example from the above repository, there is alternative_ways.dart for guys who have
very old flutter version installed.

### Usage

#### To Pick:

```
   final _controller = WebVideoPickerController();
   
    await controller.pickVideo();
    
    //OR
    
    await controller.pickMultipleVideo();
    
    //Make sure to handle WebVideoPickShowException
     
     
```

#### To show picked items for user to play one out of all:

```
ListenableBuilder(
  listenable: controller,
  builder: (context, _) {
    final data = controller.data;
     return ... //Render the items //See examples for better examples
    }
 );
 
```

<img src="img.png" alt="Example" width="1359" height="731">

As you can see in the image, two red box are the picked items. You can manage them by:

```
    controller.play(file);
    controller.remove(index);
    controller.add(file);
    controller.addMany([file1,file2]);
    controller.addRemoveManually((item)=>manage and return manually);
    controller.clear();
    controller.isVideoPlaying(fileWhichNeedToBeCheckedWhetherPlaying);
    
 
```

#### Playing the video

```
  EasyWebVideoShowWidget(
     controller: _controller,
  ),
  
  //Or if you have picked without using my package, and the file is of html.File format
   
  CustomWebVideoShowWidget(
     uniqueKey: ValueKey(someUniqueValueToDifferentiateTwoFile),
     file: fileWhichMightBePickedFromSomeOtherSource,
  ),
 ```

For detailed example please view examples, either
from [Repository](https://github.com/AradhyaNepal/web_video_pick_show) or from pub.dev's example
section.


