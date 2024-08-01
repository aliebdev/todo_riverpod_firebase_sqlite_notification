// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final int? id;
  final String? title;
  final String? desc;
  final int? isCompleted;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? remind;
  final String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? desc,
    int? isCompleted,
    String? date,
    String? startTime,
    String? endTime,
    int? remind,
    String? repeat,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      isCompleted:
          map['isCompleted'] != null ? map['isCompleted'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      remind: map['remind'] != null ? map['remind'] as int : null,
      repeat: map['repeat'] != null ? map['repeat'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, desc: $desc, isCompleted: $isCompleted, date: $date, startTime: $startTime, endTime: $endTime, remind: $remind, repeat: $repeat)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.isCompleted == isCompleted &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.remind == remind &&
        other.repeat == repeat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        isCompleted.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        remind.hashCode ^
        repeat.hashCode;
  }
}
