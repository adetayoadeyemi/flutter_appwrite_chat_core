import 'package:appwrite/appwrite.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

/// Extension with one [toShortString] method.
extension RoleToShortString on types.Role {
  /// Converts enum to the string equal to enum's name.
  String toShortString() => toString().split('.').last;
}

/// Extension with one [toShortString] method.
extension RoomTypeToShortString on types.RoomType {
  /// Converts enum to the string equal to enum's name.
  String toShortString() => toString().split('.').last;
}

/// Fetches user from Firebase and returns a promise.
Future<Map<String, dynamic>> fetchUser(
    Databases instance,
    String userId,
    String databaseId,
    String usersCollectionName, {
      String? role,
    }) async {
  final doc = await instance.getDocument(databaseId: databaseId, collectionId: usersCollectionName, documentId: userId);
  final data = doc.data!;

  //data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  data['id'] = doc.$id;
  //data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
  data['role'] = role;
  //data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

  return data;
}
