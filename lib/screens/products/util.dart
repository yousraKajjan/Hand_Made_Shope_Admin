import 'package:dash_port_hand_made/shared/component.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source, context) async {
  ImagePicker imagepicker = ImagePicker();
  XFile? file = await imagepicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    message(context, 'No Image Selected');
    print('No Image Selected');
  }
}
