// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int id;
  final int isVerified;

  UserModel({
    required this.id,
    required this.isVerified,
  });

  UserModel copyWith({
    int? id,
    int? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      isVerified: map['isVerified'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, isVerified: $isVerified)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.isVerified == isVerified;
  }

  @override
  int get hashCode => id.hashCode ^ isVerified.hashCode;
}
