import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appwrite_chat_core/flutter_appwrite_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'util.dart';

class UsersPage extends StatelessWidget {

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text('Users'),
    ),
    body: StreamBuilder<List<types.User>>(
      stream: AppwriteChatCore.instance.users(),
      initialData: const [],
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 200,
            ),
            child: const Text('No users'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final user = snapshot.data![index];

            return GestureDetector(
              onTap: () {
                print('PRESSED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    _buildAvatar(user),
                    Text(getUserName(user)),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
          name.isEmpty ? '' : name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        )
            : null,
      ),
    );
  }
}
