library flutter_appwrite_chat_core;
import 'package:appwrite/appwrite.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:appwrite/models.dart' as models;
import 'util.dart';

class AppwriteChatCore {

  Client? _client;
  models.Account? _appwriteUser;

  setClient(Client passedClient){
    _client = passedClient;
  }

  setUser(models.Account passedUser){
    _appwriteUser = passedUser;
  }

  bool get isReady => _client!=null && _appwriteUser!=null;

  AppwriteChatCore._privateConstructor(){}

  static final AppwriteChatCore instance = AppwriteChatCore._privateConstructor();

  Databases getAppwriteDb() => Databases(_client!);

  Stream<List<types.User>> users(){
    if(!isReady) return const Stream.empty();
    Stream<models.DocumentList> usersDocsStream = getAppwriteDb().listDocuments(databaseId: '63b995c6dff91a90c667', collectionId: '63b995cd467e4e4a7ab6').asStream();
    return usersDocsStream.map((event) => event.documents.fold<List<types.User>>(
      [],
          (previousValue, doc) {
        if (_appwriteUser!.$id == doc.$id) return previousValue;

        final data = doc.data;

        //data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
        data['id'] = doc.$id;
        //data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
        //data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

        return [...previousValue, types.User.fromJson(data)];
      },
    ),);
  }

  createUserInAppWrite(types.User user) async{
    await getAppwriteDb().createDocument(databaseId: '63b995c6dff91a90c667', collectionId: '63b995cd467e4e4a7ab6', documentId: user.id, data: {
      //'createdAt': FieldValue.serverTimestamp(),
      'firstName': user.firstName,
      'imageUrl': user.imageUrl,
      'lastName': user.lastName,
      //'lastSeen': FieldValue.serverTimestamp(),
      'metadata': user.metadata,
      'role': user.role?.toShortString(),
      //'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
