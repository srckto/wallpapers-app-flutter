class ImageModel {
  late String imageUrl;
  String? imageId;
  late String date;
  late String uploaded_by;
  late Map<String , dynamic> favorites;

  ImageModel({
    required this.imageUrl,
    required this.date,
    required this.uploaded_by,
    required this.favorites,
    this.imageId,
  });

  toMap() {
    return {
      "imageUrl": this.imageUrl,
      "imageId": this.imageId,
      "date": this.date,
      "uploaded_by": this.uploaded_by,
      "favorites": this.favorites,
    };
  }

  ImageModel.fromJson(Map<String, dynamic> jsonData) {
    this.imageUrl = jsonData["imageUrl"];
    this.date = jsonData["date"];
    this.imageId = jsonData["imageId"];
    this.uploaded_by = jsonData["uploaded_by"];
    this.favorites = jsonData["favorites"];
  }
}
