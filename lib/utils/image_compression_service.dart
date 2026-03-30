import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<String> compressAndEncodeImage(File file) async {
  final result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
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
