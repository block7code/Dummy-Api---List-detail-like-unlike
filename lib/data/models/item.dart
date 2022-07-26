import 'package:get/get.dart';

class Item {
  int id;
  String postID;
  String fullName;
  String publishDate;
  String image;
  String imagePost;
  String text;
  String website;
  int likes;
  RxBool inWishList;

  Item({
    required this.id,
    required this.fullName,
    required this.postID,
    required this.publishDate,
    required this.image,
    required this.imagePost,
    required this.text,
    required this.website,
    required this.likes,
    required this.inWishList,
  });
}
