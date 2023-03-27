import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  PostClass post = PostClass();
  List<PostClass> postList = [];
  List<PostClass> selectedPostList = [];
  List visibleList = [].obs;
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int limit = 50;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    fetchPost();
  }


  void selectItem(PostClass item, bool isSelected) {
    item.isSelected = isSelected;
    if (isSelected) {
      selectedPostList.add(item);
    } else {
      selectedPostList.remove(item);
    }
    update();
  }


  void searchPost(String value) {
    visibleList = postList
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
    update();
  }

  Future fetchPost() async {
    isLoading = true;
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page'));
    if (response.statusCode == 200) {
      final newList = jsonDecode(response.body);
      page++;
      if (newList.length < limit) {
        hasMore = false;
      }
      newList.forEach((element) {
        post = PostClass.fromJson(element);
        postList.add(post);
        visibleList = postList;
      });
      update();
      isLoading = false;
    } else {
      isLoading = false;
    }
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      fetchPost();
      update();
    }
  }

  onRefereshPost() async {
    await Future.delayed(const Duration(seconds: 2));
    postList.clear();
    page = 1;
    hasMore = true;
    fetchPost();
    update();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
