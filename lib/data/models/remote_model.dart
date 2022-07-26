import 'dart:convert';

class UserListResponse {
  final int total;
  final int page;
  final int limit;
  final List<ListUser> userList;

  UserListResponse(
      {required this.total,
      required this.page,
      required this.limit,
      required this.userList});

  factory UserListResponse.fromJson(Map<String, dynamic> json) {
    List<ListUser> list = [];
    if (json['data'] != null && json['data'] is List) {
      for (var i = 0; i < json['data'].length; i++) {
        list.add(ListUser.fromJson(json['data'][i]));
      }
    }
    return UserListResponse(
        total: json['total'],
        page: json['page'],
        limit: json['limit'],
        userList: list);
  }
}

class ListUser {
  ListUser({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  final String id;
  final String title;
  late final String firstName;
  final String lastName;
  final String picture;

  factory ListUser.fromJson(Map<String, dynamic> json) {
    return ListUser(
      id: json['id'],
      title: json['title'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      picture: json['picture'].toString(),
    );
  }
}

UserDetailResponse userDetailResponseFromJson(String str) =>
    UserDetailResponse.fromJson(json.decode(str));

String userDetailResponseToJson(UserDetailResponse data) =>
    json.encode(data.toJson());

class UserDetailResponse {
  UserDetailResponse({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
  });

  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  DateTime? dateOfBirth;
  String? phone;
  Location? location;

  DateTime? registerDate;
  DateTime? updatedDate;

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) =>
      UserDetailResponse(
        id: json["id"].toString(),
        title: json["title"].toString(),
        firstName: json["firstName"].toString(),
        lastName: json["lastName"].toString(),
        picture: json["picture"].toString(),
        gender: json["gender"].toString(),
        email: json["email"].toString(),
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        phone: json["phone"].toString(),
        location: Location.fromJson(json["location"]),
        registerDate: DateTime.parse(json["registerDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
        "gender": gender,
        "email": email,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "phone": phone,
        "location": location!.toJson(),
        "registerDate": registerDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
      };
}

class Location {
  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  String street;
  String city;
  String state;
  String country;
  String timezone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "timezone": timezone,
      };
}

// User post
UserPostResponse postListFromJson(String str) =>
    UserPostResponse.fromJson(json.decode(str));

String postListToJson(UserPostResponse data) => json.encode(data.toJson());

class UserPostResponse {
  UserPostResponse({
    required this.listPost,
    required this.total,
    required this.page,
    required this.limit,
  });

  List<PostList> listPost;
  int total;
  int page;
  int limit;

  factory UserPostResponse.fromJson(Map<String, dynamic> json) =>
      UserPostResponse(
        listPost:
            List<PostList>.from(json["data"].map((x) => PostList.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(listPost.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
      };
}

class PostList {
  PostList({
    required this.id,
    required this.image,
    required this.likes,
    required this.tags,
    required this.text,
    required this.publishDate,
    required this.owner,
  });

  String id;
  String image;
  int likes;
  List<String> tags;
  String text;
  DateTime publishDate;
  Owner owner;

  factory PostList.fromJson(Map<String, dynamic> json) => PostList(
        id: json["id"],
        image: json["image"],
        likes: json["likes"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        text: json["text"],
        publishDate: DateTime.parse(json["publishDate"]),
        owner: Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "likes": likes,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "text": text,
        "publishDate": publishDate.toIso8601String(),
        "owner": owner.toJson(),
      };
}

class Owner {
  Owner({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
      };
}

// data user
class DataUser {
  String name, value;
  DataUser({required this.name, required this.value});
}
