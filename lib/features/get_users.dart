import 'package:flutter/material.dart';
import 'package:retrofit_example/model/model.dart';
import '../repo_class.dart';


class GetUsers extends StatefulWidget {
  const GetUsers({Key? key}) : super(key: key);

  @override
  State<GetUsers> createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

// build list view & manage states
  FutureBuilder<List<UserRequest>> _buildBody(BuildContext context) {
    RepoClass repoClass = RepoClass();
    final client = repoClass.getUsersData();
    return FutureBuilder<List<UserRequest>>(
      future: client,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<UserRequest>? users = snapshot.data;
          return _buildListView(context, users!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  Widget _buildListView(BuildContext context, List<UserRequest> users) {
    return
      ListView.builder(itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.account_box,color: Colors.green,size: 50,),
            title: Text(users[index].name, style: const TextStyle(fontSize: 20),),
            subtitle: Text(users[index].email),
          ),
        );
      },itemCount: users.length,
      );
  }
}