import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class MyPickedImage extends ChangeNotifier {
  MyPickedImage({this.pickImage, this.webImage});

  //variável utilizada para obter, especificamente,  imagens da câmera do table/celular
  File? pickImage;
  Uint8List? webImage = Uint8List(8);

  myPickedImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? image;
    var imageSelected;
    if (!kIsWeb) {
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageSelected = File(image.path);
        pickImage = imageSelected;
        notifyListeners();
      }
    } else if (kIsWeb) {
      image = await _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
      if (image != null) {
        imageSelected = await image.readAsBytes();
        webImage = imageSelected;
        pickImage = File('a');
        notifyListeners();
      }
    }
  }
}
