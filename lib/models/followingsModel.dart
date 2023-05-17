class FollowingsModel {
  int? id;
  String? username;
  String ?email;
  String? fullname;
  bool? isVerify;
  String? image;

  FollowingsModel(
      {this.id,
      this.username,
      this.email,
      this.fullname,
      this.isVerify,
      this.image});

  FollowingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    isVerify = json['is_verify'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['is_verify'] = this.isVerify;
    data['image'] = this.image;
    return data;
  }
}
