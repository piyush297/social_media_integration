import 'dart:developer';

import 'package:facebook_login/models/picture_model.dart';

class UserModel {
  final String? email;
  final String? id;
  final String? name;
  final PictureModel? pictureModel;

  const UserModel({this.name, this.pictureModel, this.email, this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return UserModel(
      email: json['email']??"No email present",
      id: json['id'] as String?,
      name: json['name'],
      pictureModel: PictureModel.fromJson(json['picture']['data']));}

  /*
  Sample result of get user data method
  {
    "email" = "dsmr.apps@gmail.com",
    "id" = 3003332493073668,
    "name" = "Darwin Morocho",
    "picture" = {
        "data" = {
            "height" = 50,
            "is_silhouette" = 0,
            "url" = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3003332493073668",
            "width" = 50,
        },
    }
}
   */
}
