import 'package:appwrite/appwrite.dart';
class AppwriteService {
  Client _client = Client();
  AppwriteService._privateConstructor(){
    _client!
        .setEndpoint('http://172.20.10.7/v1')
        .setProject('63b8d0b12f059370b3f3')
        .setSelfSigned(status: true); // For self signed certificates, only use for development
  }

  static final AppwriteService instance = AppwriteService._privateConstructor();

  Client get getClient => _client;
}