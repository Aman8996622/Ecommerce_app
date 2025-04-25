import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final RxBool isUploading = false.obs;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage.value == null) {
      Get.snackbar(
        'Error',
        'Please select an image first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUploading.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Image uploaded successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear the selected image after upload
      selectedImage.value = null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUploading.value = false;
    }
  }
}

