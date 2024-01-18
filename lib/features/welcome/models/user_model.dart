import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  String name;
  String? image;

  UserModel({
    this.id,
    required this.name,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  static UserModel empty() => UserModel(
        id: '',
        name: '',
        image: '',
      );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );
}
