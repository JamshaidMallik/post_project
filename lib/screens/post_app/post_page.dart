import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/screens/show_selectd_post_screen.dart';
import '../../constant/constant.dart';
import '../../controller/post_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/post_card_widget.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(PostController());
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (postController) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Posts',
                style: bigFontStyle(),
              ),
              actions: [
                postController.selectedPostList.isNotEmpty?  InkWell(
                    onTap: () => Get.to(const SelectedPostsScreen()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: randomColor[Random().nextInt(randomColor.length)],
                        child: Text(
                          postController.selectedPostList.length.toString(),
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    )
                ):Container(),
              ],
            ),
            body: RefreshIndicator(
              backgroundColor: whiteColor,
              color: randomColor[Random().nextInt(randomColor.length)],
              onRefresh: () => postController.onRefereshPost(),
              child: Column(
                children: [
                  CupertinoSearchTextField(
                    onChanged: (value) => postController.searchPost(value),
                    placeholder: 'Search',
                    style: TextStyle(
                        color: Get.find<ThemeController>().isDark
                            ? Colors.white
                            : Colors.black),
                    placeholderStyle: TextStyle(
                        color: Get.find<ThemeController>().isDark
                            ? Colors.white
                            : Colors.black),
                    prefixInsets: const EdgeInsets.all(10),
                    suffixInsets: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: (postController.visibleList.isNotEmpty)
                        ? ListView.builder(
                            controller: postController.scrollController,
                            itemCount: postController.visibleList.length + 1,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (index < postController.visibleList.length) {
                                var item = postController.visibleList[index];
                                return PostCardWidget(item: item);
                              } else {
                                return loadingWidget(postController);
                              }
                            })
                        : const Center(child: Text('No Match Found')),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// ignore: camel_case_types
class loadingWidget extends StatelessWidget {
  final PostController Controller;
  const loadingWidget(
    this.Controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
          child: Controller.hasMore
              ? CircularProgressIndicator(
                  color: randomColor[Random().nextInt(randomColor.length)])
              : const Text('has no more data')),
    );
  }
}