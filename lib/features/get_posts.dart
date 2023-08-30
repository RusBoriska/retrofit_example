import 'package:flutter/material.dart';
import 'package:retrofit_example/model/model.dart';
import '/repo_class.dart';


class GetPosts extends StatefulWidget {
  const GetPosts({Key? key}) : super(key: key);

  @override
  State<GetPosts> createState() => _GetPostsState();
}

class _GetPostsState extends State<GetPosts> {

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

// build list view & manage states
  FutureBuilder<List<PostRequest>> _buildBody(BuildContext context) {
    RepoClass repoClass = RepoClass();
    final client = repoClass.getPostsData();
    return FutureBuilder<List<PostRequest>>(
      future: client,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<PostRequest>? posts = snapshot.data;
          return _buildListView(context, posts!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  Widget _buildListView(BuildContext context, List<PostRequest> posts) {
    return
      ListView.builder(itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.account_box,color: Colors.green,size: 50,),
            title: Text(posts[index].title, style: const TextStyle(fontSize: 20),),
            subtitle: Text(posts[index].body),
          ),
        );
      },itemCount: posts.length,
      );
  }
}