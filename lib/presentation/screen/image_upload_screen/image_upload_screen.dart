import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp/presentation/screen/image_upload_screen/image_upload_controller.dart';

class ImageUploadScreen extends StatelessWidget {
  final ImageUploadController controller = Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Preview
              Obx(() {
                return Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: controller.selectedImage.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No image selected',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                );
              }),
              SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.pickImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo_library),
                    label: Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.pickImage(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Upload Button
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isUploading.value
                        ? null
                        : controller.uploadImage,
                    child: controller.isUploading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Upload Image'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
