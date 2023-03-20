import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/post_model.dart';
class PostController {
  String postUrl = 'https://jsonplaceholder.typicode.com/posts';
  List<PostClass> postList = [];
  PostClass post = PostClass();
  bool isLoading = false;
  Future getPost()async{
    isLoading = true;
    var response = await http.get(Uri.parse(postUrl));
    if(response.statusCode == 200){
      post = PostClass.fromJson(jsonDecode(response.body));
      postList.add(post);
      isLoading = false;
      print('reponse= ${response.body}');
    }else{
      isLoading = false;
      print('error from server');
    }
    return response;
  }

}