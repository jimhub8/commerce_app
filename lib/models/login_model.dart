import 'dart:ffi';

class LoginResponseModel {
  bool success;
  int statusCode;
  String code;
  String message;
  Data data;

  LoginResponseModel(
      {this.success, this.statusCode, this.code, this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.statusCode = json['statusCode'];
    this.code = json['code'];
    this.message = json['message'];
    this.data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token;
  int id;
  String email;
  String nicename;
  String firstname;
  String lastname;
  String displayname;

  Data({
    this.token,
    this.id,
    this.email,
    this.nicename,
    this.firstname,
    this.lastname,
    this.displayname,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    nicename = json['nicename'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    displayname = json['displayname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['nicename'] = this.nicename;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['displayname'] = this.displayname;
    return data;
  }
}
