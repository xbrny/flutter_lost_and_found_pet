import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class AbstractPostApi {
  Future<List<DocumentSnapshot>> fetchByTypeRaw(
      PostType postType, DocumentSnapshot lastDocument,
      [limit]);

  Future<List<DocumentSnapshot>> fetchByUidRaw(
      String uid, DocumentSnapshot lastDocument,
      [limit]);

  Future<Post> fetchById(String id);

  Future<Post> create(Post post, List<Asset> images);

  Future<Post> update(String id, Post post);

  Future<String> delete(String id);
}
