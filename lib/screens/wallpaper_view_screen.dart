import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/wallpaper_view_controller.dart';
import 'package:wally_app/models/image_model.dart';

class WallpaperViewScreen extends StatelessWidget {
  WallpaperViewScreen({Key? key, required this.imageModel, required this.heroTag});

  final ImageModel imageModel;
  final String heroTag;
  final WallpaperViewController _wallpaperViewController = Get.put(WallpaperViewController());

  @override
  Widget build(BuildContext context) {
    _wallpaperViewController.getIsFavorite(imageModel);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  child: Hero(
                    tag: imageModel.imageId! + heroTag,
                    child: CachedNetworkImage(
                      placeholder: (ctx, url) => Image(
                        image: AssetImage("assets/placeholder.jpg"),
                      ),
                      imageUrl: imageModel.imageUrl,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.file_download),
                        // onPressed: _launchURL,
                        label: Text("Get wallpaper"),
                        onPressed: () => _wallpaperViewController.launchURL(imageModel.imageUrl),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.share),
                        // onPressed: _createDynamicLink,
                        label: Text("Share"),
                        onPressed: () =>
                            _wallpaperViewController.createDynamicLink(imageModel: imageModel),
                      ),
                      GetBuilder<WallpaperViewController>(
                        builder: (_) {
                          return ElevatedButton.icon(
                            icon: Icon(
                              _wallpaperViewController.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            label: Text("Favorite"),
                            onPressed: () {
                              _wallpaperViewController.addToFavoriteOrDelete(
                                imageModel: imageModel,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 15),
        child: FloatingActionButton(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 27,
          ),
          backgroundColor: Colors.deepOrange,
          onPressed: () => Get.back(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
