import 'dart:convert';

class UserData {
  String firstName;
  String lastName;
  String email;
  String passWord;
  String confirmPassword;
  String gender;
  String phoneNumber;

  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.passWord,
    this.confirmPassword,
    this.gender,
    this.phoneNumber,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.passWord;
    data['confirm_password'] = this.confirmPassword;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNumber;
    return data;
  }
}

RegisterResponseModel userFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));
String userToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  int status;
  dynamic data;
  String message;
  String userMsg;

  RegisterResponseModel({this.status, this.message, this.userMsg, this.data});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json['status'],
        data: json['data'] != null
            ? json['data'].runtimeType == bool
                ? false
                : RegisterSuccessModel.fromJson(json['data'])
            : null,
        message: json['message'],
        userMsg: json['user_msg'],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
        "user_msg": userMsg
      };
}

class RegisterSuccessModel {
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

  RegisterSuccessModel({
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

  factory RegisterSuccessModel.fromJson(Map<String, dynamic> json) =>
      RegisterSuccessModel(
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
