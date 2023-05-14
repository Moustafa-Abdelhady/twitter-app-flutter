class UserModel {
  int ?id;
  Profile ?profile;
  List<Followers> ?followers;
  List<Following>? following;
  Null? lastLogin;
  String? email;
  String? username;
  String? fullname;
  String? birthdate;
  String? createAt;
  bool? isActive;
  bool? isAdmin;
  bool? isVerify;

  UserModel(
      {this.id,
      this.profile,
      this.followers,
      this.following,
      this.lastLogin,
      this.email,
      this.username,
      this.fullname,
      this.birthdate,
      this.createAt,
      this.isActive,
      this.isAdmin,
      this.isVerify});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following =<Following>[];
      json['following'].forEach((v) {
        following!.add(new Following.fromJson(v));
      });
    }
    lastLogin = json['last_login'];
    email = json['email'];
    username = json['username'];
    fullname = json['fullname'];
    birthdate = json['birthdate'];
    createAt = json['create_at'];
    isActive = json['is_active'];
    isAdmin = json['is_admin'];
    isVerify = json['is_verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    data['last_login'] = this.lastLogin;
    data['email'] = this.email;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['birthdate'] = this.birthdate;
    data['create_at'] = this.createAt;
    data['is_active'] = this.isActive;
    data['is_admin'] = this.isAdmin;
    data['is_verify'] = this.isVerify;
    return data;
  }
}

class Following {
  Following.fromJson(v);

  toJson() {}
}

class Profile {
  int?id;
  String? location;
  String? website;
  String? bio;
  String? image;
  String? coverImage;
  int? user;

  Profile(
      {this.id,
      this.location,
      this.website,
      this.bio,
      this.image,
      this.coverImage,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    website = json['website'];
    bio = json['bio'];
    image = json['image'];
    coverImage = json['cover_image'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['website'] = this.website;
    data['bio'] = this.bio;
    data['image'] = this.image;
    data['cover_image'] = this.coverImage;
    data['user'] = this.user;
    return data;
  }
}

class Followers {
  int ?id;
  Follower ?follower;
  Follower ?following;

  Followers({this.id, this.follower, this.following});

  Followers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    follower = json['follower'] != null
        ? new Follower.fromJson(json['follower'])
        : null;
    following = json['following'] != null
        ? new Follower.fromJson(json['following'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.follower != null) {
      data['follower'] = this.follower!.toJson();
    }
    if (this.following != null) {
      data['following'] = this.following!.toJson();
    }
    return data;
  }
}

class Follower {
  String ?username;
  String ?fullname;
  String ?image;

  Follower({this.username, this.fullname, this.image});

  Follower.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['image'] = this.image;
    return data;
  }
}




// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//     int id;
//     Profile profile;
//     List<dynamic> followers;
//     List<Following> following;
//     DateTime lastLogin;
//     String email;
//     String username;
//     String fullname;
//     DateTime birthdate;
//     DateTime createAt;
//     bool isActive;
//     bool isAdmin;
//     bool isVerify;

//     UserModel({
//         required this.id,
//         required this.profile,
//         required this.followers,
//         required this.following,
//         required this.lastLogin,
//         required this.email,
//         required this.username,
//         required this.fullname,
//         required this.birthdate,
//         required this.createAt,
//         required this.isActive,
//         required this.isAdmin,
//         required this.isVerify,
//     });

//     factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["id"],
//         profile: Profile.fromJson(json["profile"]),
//         followers: List<dynamic>.from(json["followers"].map((x) => x)),
//         following: List<Following>.from(json["following"].map((x) => Following.fromJson(x))),
//         lastLogin: DateTime.parse(json["last_login"]),
//         email: json["email"],
//         username: json["username"],
//         fullname: json["fullname"],
//         birthdate: DateTime.parse(json["birthdate"]),
//         createAt: DateTime.parse(json["create_at"]),
//         isActive: json["is_active"],
//         isAdmin: json["is_admin"],
//         isVerify: json["is_verify"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "profile": profile.toJson(),
//         "followers": List<dynamic>.from(followers.map((x) => x)),
//         "following": List<dynamic>.from(following.map((x) => x.toJson())),
//         "last_login": lastLogin.toIso8601String(),
//         "email": email,
//         "username": username,
//         "fullname": fullname,
//         "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
//         "create_at": createAt.toIso8601String(),
//         "is_active": isActive,
//         "is_admin": isAdmin,
//         "is_verify": isVerify,
//     };
// }

// class Following {
//     int id;
//     Follow follower;
//     Follow following;

//     Following({
//         required this.id,
//         required this.follower,
//         required this.following,
//     });

//     factory Following.fromJson(Map<String, dynamic> json) => Following(
//         id: json["id"],
//         follower: Follow.fromJson(json["follower"]),
//         following: Follow.fromJson(json["following"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "follower": follower.toJson(),
//         "following": following.toJson(),
//     };
// }

// class Follow {
//     String username;
//     String fullname;
//     String? image;

//     Follow({
//         required this.username,
//         required this.fullname,
//         this.image,
//     });

//     factory Follow.fromJson(Map<String, dynamic> json) => Follow(
//         username: json["username"],
//         fullname: json["fullname"],
//         image: json["image"],
//     );

//     Map<String, dynamic> toJson() => {
//         "username": username,
//         "fullname": fullname,
//         "image": image,
//     };
// }

// class Profile {
//     int id;
//     String location;
//     String website;
//     String bio;
//     String image;
//     String coverImage;
//     int user;

//     Profile({
//         required this.id,
//         required this.location,
//         required this.website,
//         required this.bio,
//         required this.image,
//         required this.coverImage,
//         required this.user,
//     });

//     factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//         id: json["id"],
//         location: json["location"],
//         website: json["website"],
//         bio: json["bio"],
//         image: json["image"],
//         coverImage: json["cover_image"],
//         user: json["user"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "location": location,
//         "website": website,
//         "bio": bio,
//         "image": image,
//         "cover_image": coverImage,
//         "user": user,
//     };
// }
