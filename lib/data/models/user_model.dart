class UserModel {
  String? id;
  String? email;
  String? username;
  String? token;

  UserModel({this.id, this.email, this.username, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    email = json['email'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['token'] = this.token;
    return data;
  }
}
