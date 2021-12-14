import 'dart:convert';

class LoginData {
  String email;
  String password;

  LoginData({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> loginData = new Map<String, dynamic>();
    loginData["email"] = this.email;
    loginData["password"] = this.password;
    return loginData;
  }
}

LoginResponseModel userLoginFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
String userToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  int status;
  String message;
  String userMsg;
  LoginSuccessModel success;

  LoginResponseModel({
    this.status,
    this.message,
    this.userMsg,
    this.success,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status:
    json['status'];
    message:
    json['message'];
    userMsg:
    json['user_msg'];

    Map<String, dynamic> map = json['success'];
    success:
    LoginSuccessModel.fromJson(map);
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": success.toJson(),
        "message": message,
        "user_msg": userMsg
      };
}

class LoginSuccessModel {
  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  dynamic profilePic;
  dynamic countryId;
  String gender;
  String phoneNo;
  dynamic dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  LoginSuccessModel({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.gender,
    this.profilePic,
    this.countryId,
    this.phoneNo,
    this.dob,
    this.isActive,
    this.created,
    this.modified,
    this.accessToken,
  });

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    LoginSuccessModel(
      id: json['id'],
      roleId: json['role_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      profilePic: json["profile_pic"],
      countryId: json["country_id"],
      gender: json['gender'],
      phoneNo: json['phone_no'],
      dob: json["dob"],
      isActive: json['is_active'],
      created: json['created'],
      modified: json['modified'],
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "username": username,
        "profile_pic": profilePic,
        "country_id": countryId,
        "gender": gender,
        "phone_no": phoneNo,
        "dob": dob,
        "is_active": isActive,
        "created": created,
        "modified": modified,
        "access_token": accessToken,
      };
}
