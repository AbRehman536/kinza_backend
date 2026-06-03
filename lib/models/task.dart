// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';


class TaskModel {
  final String? docId;
  final String? priorityID;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final List<dynamic>? saved;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.priorityID,
    this.title,
    this.description,
    this.isCompleted,
    this.saved,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docId"],
    priorityID: json["priorityID"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
    saved: json["saved"] == null ? [] : List<dynamic>.from(json["saved"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docId": taskID,
    "priorityID": priorityID,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
    "saved": saved == null ? [] : List<dynamic>.from(saved!.map((x) => x)),
    "createdAt": createdAt,
  };
}
