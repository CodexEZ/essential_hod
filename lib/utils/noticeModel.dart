// To parse this JSON data, do
//
//     final noticeApiModel = noticeApiModelFromJson(jsonString);

import 'dart:convert';

NoticeApiModel noticeApiModelFromJson(String str) => NoticeApiModel.fromJson(json.decode(str));

String noticeApiModelToJson(NoticeApiModel data) => json.encode(data.toJson());

class NoticeApiModel {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  NoticeApiModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory NoticeApiModel.fromJson(Map<String, dynamic> json) => NoticeApiModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? topic;
  String? heading;
  String? content;
  String? file;
  List<String>? target;
  String? links;
  DateTime? timestamp;
  String? college;
  dynamic hod;
  dynamic warden;

  Result({
    this.id,
    this.topic,
    this.heading,
    this.content,
    this.file,
    this.target,
    this.links,
    this.timestamp,
    this.college,
    this.hod,
    this.warden,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    topic: json["topic"],
    heading: json["heading"],
    content: json["content"],
    file: json["file"],
    target: json["target"] == null ? [] : List<String>.from(json["target"]!.map((x) => x)),
    links: json["links"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    college: json["college"],
    hod: json["hod"],
    warden: json["warden"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "heading": heading,
    "content": content,
    "file": file,
    "target": target == null ? [] : List<dynamic>.from(target!.map((x) => x)),
    "links": links,
    "timestamp": timestamp?.toIso8601String(),
    "college": college,
    "hod": hod,
    "warden": warden,
  };
}
