import 'package:cloud_firestore/cloud_firestore.dart';

class StepModel {
  String? description;
  String? step_name;
  Timestamp? startDate;
  Timestamp? endDate;

  StepModel({
    this.description,
    this.step_name,
    this.startDate,
    this.endDate,
  });

  StepModel.withId({
    this.description,
    this.step_name,
    this.startDate,
    this.endDate,
  });

//convert text to map to be stored
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['description'] = description;
    map['step_name'] = step_name;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    return map;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel.withId(
      description: map['description'],
      step_name: map['step_name'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}
