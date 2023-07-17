
import 'dart:convert';
import 'package:flutter/services.dart';

void checkBase64Image(String base64Image) {
  try {
    final bytes = base64Decode(base64Image);
    // Save the decoded bytes to a temporary file or display the image directly
    // using an Image widget to confirm that it represents the expected image data.
    // For example:
    // final tempFile = File('path_to_temp_file.jpg');
    // tempFile.writeAsBytes(bytes);

    // If the image is displayed without any errors, it means the base64 string is valid.
    print('Base64 image is valid.');
  } catch (e) {
    print('Base64 image is invalid. Error: $e');
  }
}

void main() {
  // Assuming you have the base64 image string in the category.image property
  final categoryImage = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAsJCQcJCQcJCQkJCwkJCQkJCQsJCwsMCwsLDA0QDBEODQ4MEhkSJRodJR0ZHxwpKRYlNzU2GioyPi0pMBk7IRP/2wBDAQcICAsJCxULCxUsHRkdLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCz/wAARCADqAJUDASIAAhEB';

  checkBase64Image(categoryImage);
}