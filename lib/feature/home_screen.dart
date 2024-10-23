import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_retrofit/models/post_model.dart';
import 'package:learn_retrofit/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  FutureBuilder _body() {
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiService.getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<PostModel> posts = snapshot.data;
            return _post(posts);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }

  Widget _post(List<PostModel> posts){
     return ListView.builder(
      itemCount: posts.length ,
      itemBuilder: (context, index) {
        return Container(
         
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: Colors.yellow,
          child: ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body,overflow: TextOverflow.clip,),
          )
        );
      });
  }
}
