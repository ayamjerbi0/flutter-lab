import 'package:flutter/material.dart';
import 'package:lab/api/users_api.dart';
import 'package:lab/model/user.dart';

class UserNetworkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<User>>(
          future: UsersApi.getUsers(),
          builder: (context, snapshot) {
            final users = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildUsers(users!);
                }
            }
          },
        ),
      );

  Widget buildUsers(List<User> users) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return ListTile(
            onTap: (){},
            /*=> Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => UserPage(user: user),
            )),*/
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.urlAvatar),
            ),
            title: Text(user.username),
            subtitle: Text(user.email),
          );
        },
      );
}
