import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wally_app/controllers/account_controller.dart';
import 'package:wally_app/controllers/exploar_controller.dart';
import 'package:wally_app/controllers/favorite_controller.dart';
import 'package:wally_app/controllers/user_controller.dart';
import 'package:wally_app/screens/add_wallpaper_screen.dart';
import 'package:wally_app/screens/login_screen.dart';

import 'wallpaper_view_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final AccountController _accountController = Get.put(AccountController());
  final String _heroTag = "accountScreen";

  @override
  Widget build(BuildContext context) {
    // _accountController.getImagesOfUser();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: FadeInImage(
                placeholder: AssetImage("assets/placeholder.jpg"),
                image: NetworkImage(UserController.userModel.image),
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "${UserController.userModel.name}",
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Get.off(() => LogInScreen());
                // Get.delete<ExploarController>();
                // Get.delete<FavoriteController>();
                // Get.delete<AccountController>();
              },
              child: Text(
                "LogOut",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "My Wallpapers",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Get.to(() => AddWallpaperScreen());
                    _accountController.getImagesOfUser();
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
            GetBuilder<AccountController>(
              // init: AccountController(),
              builder: (_) {
                return _accountController.images.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Center(
                          child: Text(
                            "You don't have any image yet",
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
                        itemCount: _accountController.images.length,
                        itemBuilder: (BuildContext context, int index) => Stack(
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(
                                () => WallpaperViewScreen(
                                  imageModel: _accountController.images[index],
                                  heroTag: _heroTag,
                                ),
                              ),
                              child: Hero(
                                tag: _accountController.images[index].imageId! + _heroTag,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: _accountController.images[index].imageUrl,
                                    placeholder: (context, url) => FadeInImage(
                                      placeholder: AssetImage("assets/placeholder.jpg"),
                                      image: NetworkImage(url),
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    title: Text("Confirmation"),
                                    content: Text("Are you sure, you are deleting wallpaper"),
                                    actions: [
                                      ElevatedButton(
                                        child: Text("Cancel"),
                                        onPressed: () => Get.back(),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                        ),
                                        child: Text("DELETE"),
                                        onPressed: () {
                                          _accountController
                                              .deleteImage(_accountController.images[index]);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
