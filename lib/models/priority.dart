// To parse this JSON data, do
//
//     final priorityTaskModel = priorityTaskModelFromJson(jsonString);

import 'dart:convert';

class PriorityTaskModel {
  final String? docId;
  final String? label;
  final int? createdAt;

  PriorityTaskModel({
    this.docId,
    this.label,
    this.createdAt,
  });

  factory PriorityTaskModel.fromJson(Map<String, dynamic> json) => PriorityTaskModel(
    docId: json["docID"],
    label: json["label"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String priorityID) => {
    "docID": priorityID,
    "label": label,
    "createdAt": createdAt,
  };
}
