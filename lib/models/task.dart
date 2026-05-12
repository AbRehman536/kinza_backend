// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docId"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
  };
}
