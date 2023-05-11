import 'dart:convert';

// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
    int id;
    String content;
    Comments likes;
    Comments comments;
    Comments replies;
    DateTime createAt;
    List<dynamic> media;
    User user;

    PostModel({
        required this.id,
        required this.content,
        required this.likes,
        required this.comments,
        required this.replies,
        required this.createAt,
        required this.media,
        required this.user,
    });

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        content: json["content"],
        likes: Comments.fromJson(json["likes"]),
        comments: Comments.fromJson(json["comments"]),
        replies: Comments.fromJson(json["replies"]),
        createAt: DateTime.parse(json["create_at"]),
        media: List<dynamic>.from(json["media"].map((x) => x)),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "likes": likes.toJson(),
        "comments": comments.toJson(),
        "replies": replies.toJson(),
        "create_at": createAt.toIso8601String(),
        "media": List<dynamic>.from(media.map((x) => x)),
        "user": user.toJson(),
    };
}

class Comments {
    int count;
    List<int> usersList;

    Comments({
        required this.count,
        required this.usersList,
    });

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        count: json["count"],
        usersList: List<int>.from(json["users_list"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "users_list": List<dynamic>.from(usersList.map((x) => x)),
    };
}

class User {
    int id;
    String fullname;
    String username;
    String image;
    bool isVerify;

    User({
        required this.id,
        required this.fullname,
        required this.username,
        required this.image,
        required this.isVerify,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
        image: json["image"],
        isVerify: json["is_verify"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
        "image": image,
        "is_verify": isVerify,
    };
}
