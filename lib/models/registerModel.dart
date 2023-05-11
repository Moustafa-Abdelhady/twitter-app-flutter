class RegisterModel {
  int? id;
  String? fullname;
  String? username;
  String? email;
  String? birthdate;
  String? password;

  RegisterModel(
      {this.id, this.fullname, this.username, this.email, this.birthdate, this.password});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      birthdate: json['birthdate'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['birthdate'] = this.birthdate;
    data['id'] = this.password;
    return data;
  }
}
