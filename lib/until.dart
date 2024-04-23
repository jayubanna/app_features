import 'dart:io';

class StudentData {
  String grId;
  String name;
  String std;
  File image;

  StudentData({
    required this.grId,
    required this.name,
    required this.std,
    required this.image,
  });

  factory StudentData.fromJson(Map<String,dynamic> map){
    return StudentData(
      name: map["name"],
      grId: map["grId"],
      std: map["std"],
      image: map["image"],
    );
  }

}