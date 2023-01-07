import 'package:appwrite/appwrite.dart';
import 'package:example/appwriteService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appwrite_chat_core/flutter_appwrite_chat_core.dart';
import 'UsersPage.dart';
import 'login.dart';
import 'package:appwrite/models.dart' as models;

class RoomsPage extends StatefulWidget{
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => RoomsPageState();

}

class RoomsPageState extends State<RoomsPage>{

  @override
  void initState() {
    Account(AppwriteService.instance.getClient).get().then((value){
      setState(() {
        _user = value;
      });
      AppwriteChatCore.instance.setUser(value);
    });
    if(!AppwriteChatCore.instance.isReady){
      AppwriteChatCore.instance.setClient(AppwriteService.instance.getClient);
    }
    super.initState();
  }


  models.Account? _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App Write Chat Core'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const UsersPage(),
                ));
              },
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: _user == null ? Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: 200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Not authenticated'),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ) : const Center(
        child: Text('Welcome to Flutter App Write Chat Core Sample'),
      ),
    );
  }
}