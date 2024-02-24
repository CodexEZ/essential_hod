// To parse this JSON data, do
//
//     final leaveViewApiModel = leaveViewApiModelFromJson(jsonString);

import 'dart:convert';

List<LeaveViewApiModel> leaveViewApiModelFromJson(String str) => List<LeaveViewApiModel>.from(json.decode(str).map((x) => LeaveViewApiModel.fromJson(x)));

String leaveViewApiModelToJson(List<LeaveViewApiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveViewApiModel {
  int? id;
  String? student;
  String? name;
  String? reason;
  DateTime? departure;
  DateTime? arrival;
  String? branch;
  String? hostel;
  String? status;
  String? denialReason;
  String? hash;
  String? sem;
  String? batch;
  String? phone;

  LeaveViewApiModel({
    this.id,
    this.student,
    this.name,
    this.reason,
    this.departure,
    this.arrival,
    this.branch,
    this.hostel,
    this.status,
    this.denialReason,
    this.hash,
    this.sem,
    this.batch,
    this.phone,
  });

  factory LeaveViewApiModel.fromJson(Map<String, dynamic> json) => LeaveViewApiModel(
    id: json["id"],
    student: json["student"],
    name: json["name"],
    reason: json["reason"],
    departure: json["departure"] == null ? null : DateTime.parse(json["departure"]),
    arrival: json["arrival"] == null ? null : DateTime.parse(json["arrival"]),
    branch: json["branch"],
    hostel: json["hostel"],
    status: json["status"],
    denialReason: json["denial_reason"],
    hash: json["hash"],
    sem: json["sem"],
    batch: json["batch"],
    phone:json["phone"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student": student,
    "name": name,
    "reason": reason,
    "departure": departure?.toIso8601String(),
    "arrival": arrival?.toIso8601String(),
    "branch": branch,
    "hostel": hostel,
    "status": status,
    "denial_reason": denialReason,
    "hash": hash,
    "sem": sem,
    "batch": batch,
    "phone":phone
  };
}
