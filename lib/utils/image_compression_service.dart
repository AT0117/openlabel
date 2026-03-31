import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<String> compressAndEncodeImage(XFile file) async {
  if (kIsWeb) {
    final bytes = await file.readAsBytes();
    final base64String = base64Encode(bytes);
    return 'data:image/jpeg;base64,$base64String';
  } else {
    final result = await FlutterImageCompress.compressWithFile(
      file.path,
      minWidth: 800,
      minHeight: 800,
      quality: 80,
      format: CompressFormat.jpeg,
    );

    if (result == null) {
      throw Exception('Image compression failed');
    }

    final base64String = base64Encode(result);
    return 'data:image/jpeg;base64,$base64String';
  }
}
