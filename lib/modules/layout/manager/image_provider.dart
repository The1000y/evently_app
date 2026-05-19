import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageProviderManager extends ChangeNotifier {
  File? imge;

  imagePickerProcess(BuildContext context) async {
    try {
      // if (imge != null) return;
      ImagePicker imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();

        final saveImage = await File(
          pickedFile.path,
        ).copy(path.join(appDocumentsDir.path, 'image.jpg'));

        imge = saveImage;
      } else {
        CherryToast.error(
          animationType: AnimationType.fromTop,
          title: Text("No Image Selected"),
        ).show(context);
      }
    } on Exception catch (e) {
      CherryToast.error(
        animationType: AnimationType.fromTop,
        title: Text(e.toString()),
      ).show(context);
    } catch (e) {
      CherryToast.error(
        animationType: AnimationType.fromTop,
        title: Text(e.toString()),
      ).show(context);
    }
    notifyListeners();
  }
}
