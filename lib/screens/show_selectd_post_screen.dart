import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/widgets/post_card_widget.dart';
import '../controller/post_controller.dart';

class SelectedPostsScreen extends GetView<PostController> {
  const SelectedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Posts'),
      ),
      body:GetBuilder(
          init: PostController(),
          builder: (myController) {
            final selectedPosts = controller.selectedPostList;
            return ListView.builder(
              itemCount: selectedPosts.length,
              itemBuilder: (context, index) {
                final post = selectedPosts[index];
                return PostCardWidget(item: post);
              },
            );
          }
      ),
    );
  }
}