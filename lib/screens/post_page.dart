import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constant.dart';
import '../controller/post_controller.dart';
import '../controller/theme_controller.dart';
import '../widgets/post_card_widget.dart';

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
                    child: postController.visibleList.isNotEmpty
                        ? ListView.builder(
                            controller: postController.scrollController,
                            itemCount: postController.visibleList.length + 1,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (index < postController.visibleList.length) {
                                var item = postController.visibleList[index];
                                return postCardWidget(context, item);
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 50.0),
                                  child: Center(
                                      child: postController.hasMore
                                          ? CircularProgressIndicator(
                                              color: randomColor[Random()
                                                  .nextInt(randomColor.length)])
                                          : const Text('has no more data')),
                                );
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
