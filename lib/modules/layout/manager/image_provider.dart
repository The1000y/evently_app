import 'dart:io';

// import 'package:cherry_toast/cherry_toast.dart';
// import 'package:cherry_toast/resources/arrays.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';

class ImageProviderManager extends ChangeNotifier {
  File? imge;
  int imgeIndex = 0;
  Future<void> loadImage() async {
    final oldFile = await getApplicationDocumentsDirectory();
    final file = File(path.join(oldFile.path, 'profile_image.jpg'));
    if (await file.exists()) {
      imge = file;

      notifyListeners();
    }
  }

  Future<void> getImagePicker(BuildContext context) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        final place = await getApplicationDocumentsDirectory();
        // final oldFile = File(path.join(place.path, 'profile_image.jpg'));
        // if (await oldFile.exists()) {
        //   await oldFile.delete();
        // }

        imge = await File(
          pickedFile.path,
        ).copy(path.join(place.path, 'profile_image.jpg'));
        imageCache.clear();
        imageCache.clearLiveImages();
        imgeIndex++;
        notifyListeners();
      } else {
        // imge = null;
        CherryToast.warning(
          title: Text("No Image Selected"),
          animationType: AnimationType.fromTop,
        ).show(context);
      }
    } on Exception catch (e) {
      CherryToast.error(
        title: Text(e.toString()),
        animationType: AnimationType.fromTop,
      ).show(context);
    } catch (e) {
      CherryToast.error(
        title: Text(e.toString()),
        animationType: AnimationType.fromTop,
      ).show(context);
    }
  }
}
