class UserModel {
  String? id;
  String? name;
  String? lastname;
  String? email;
  String? password;
  String? profileImage;

  UserModel(
      {this.id,
      this.name,
      this.lastname,
      this.email,
      this.password,
      this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? "";
    data['name'] = this.name ?? "";
    data['lastname'] = this.lastname ?? "";
    data['email'] = this.email ?? "";
    data['password'] = this.password ?? "";
    data['profile_image'] = this.profileImage ?? "";
    return data;
  }
}
