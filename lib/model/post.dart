import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

enum PostType { lost, found }

@JsonSerializable()
class Post {
  String id;
  PostType postType;
  String name;
  String breed;
  String location;
  bool notifyMe;
  DateTime dateTimeLost;
  String phoneNumber;
  String additionalDetails;
  List<String> imageUrl = [];
  String uid;
  DateTime createdAt;

  Post({
    this.postType,
    this.name,
    this.breed,
    this.location,
    this.notifyMe,
    this.dateTimeLost,
    this.phoneNumber,
    this.additionalDetails,
  });

  static Post fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Post.fromJson(snapshot.data)..id = snapshot.documentID;
  }

  static Post fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  static String postTypeToJson(PostType postType) {
    return _$PostTypeEnumMap[postType];
  }

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}
