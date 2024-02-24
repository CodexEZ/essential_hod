// To parse this JSON data, do
//
//     final leaveViewApiModel = leaveViewApiModelFromJson(jsonString);

import 'dart:convert';

LeaveViewApiModel leaveViewApiModelFromJson(String str) => LeaveViewApiModel.fromJson(json.decode(str));

String leaveViewApiModelToJson(LeaveViewApiModel data) => json.encode(data.toJson());

class LeaveViewApiModel {
  String? status;
  Data? data;

  LeaveViewApiModel({
    this.status,
    this.data,
  });

  factory LeaveViewApiModel.fromJson(Map<String, dynamic> json) => LeaveViewApiModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? password;

  Data({
    this.id,
    this.password,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
  };
}
