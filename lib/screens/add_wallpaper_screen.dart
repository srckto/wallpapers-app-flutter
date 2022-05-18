import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/add_wallpaper_controller.dart';

class AddWallpaperScreen extends StatelessWidget {
  AddWallpaperScreen({Key? key}) : super(key: key);

  final AddWallpaperController _addWallpaperController = Get.put(AddWallpaperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add wallpaper"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                GetBuilder<AddWallpaperController>(
                  builder: (_) => _addWallpaperController.isLoading
                      ? LinearProgressIndicator(
                          color: Colors.deepOrange,
                        )
                      : Container(),
                ),
                SizedBox(height: 10),
                GetBuilder<AddWallpaperController>(
                  builder: (_) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () => _addWallpaperController.pickedImage(),
                        child: Image(
                          image: _addWallpaperController.image == null
                              ? AssetImage("assets/placeholder.jpg")
                              : FileImage(_addWallpaperController.image!) as ImageProvider,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                GetBuilder<AddWallpaperController>(
                  builder: (_) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    ),
                    onPressed: _addWallpaperController.image != null
                        ? () {
                            _addWallpaperController.uploadImage();
                          }
                        : null,
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
