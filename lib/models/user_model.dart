class UserModel {
  late String name;
  late String email;
  late String uId;
  late String image;
  late String cover;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    required this.image,
    required this.cover,
  });

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    name = jsonData["name"];
    email = jsonData["email"];
    uId = jsonData["uId"];
    image = jsonData["image"];
    cover = jsonData["cover"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uId": uId,
      "image": image,
      "cover": cover,
    };
  }
}
