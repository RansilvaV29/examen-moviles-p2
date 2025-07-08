import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<String?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    return file?.path;
  }
}
