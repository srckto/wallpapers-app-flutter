import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/exploar_controller.dart';
import 'package:wally_app/screens/wallpaper_view_screen.dart';

class ExploarScreen extends StatelessWidget {
  ExploarScreen({Key? key}) : super(key: key);
  final ExploarController _exploarController = Get.put(ExploarController());
  final String _heroTag = "exploarScreen";

  @override
  Widget build(BuildContext context) {
    _exploarController.getImages();
    return RefreshIndicator(
      onRefresh: _exploarController.getImages,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "Exploar",
                style: TextStyle(fontSize: 30),
              ),
            ),
            GetBuilder<ExploarController>(
              // init: ExploarController(),
              builder: (_) {
                return _exploarController.images.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Text(
                            "Not found any image",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // childAspectRatio: 9 / 16,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        itemCount: _exploarController.images.length,
                        itemBuilder: (BuildContext context, int index) => Hero(
                          tag: _exploarController.images[index].imageId! +
                              _heroTag,
                          child: GestureDetector(
                            onTap: () => Get.to(() => WallpaperViewScreen(
                                  imageModel: _exploarController.images[index],
                                  heroTag: _heroTag,
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: _exploarController.images[index].imageUrl,
                                placeholder: (context, url) => FadeInImage(
                                  placeholder: AssetImage("assets/placeholder.jpg"),
                                  image: NetworkImage(url),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
// ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image(
//                 image: NetworkImage(_images[index]),
//                 fit: BoxFit.cover,
//               ),
//             ),