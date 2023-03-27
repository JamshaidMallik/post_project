import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constant.dart';
import '../controller/post_controller.dart';
import '../controller/theme_controller.dart';
import '../widgets/post_card_widget.dart';

class PostPage extends GetView<PostController> {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PostController());
    return GetBuilder(
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
                InkWell(
                    onTap: () => Get.to(SelectedPostsScreen()),
                    child: Text('Select Items  ${controller.selectedPostList.length}')),
              ],
            ),
            body: RefreshIndicator(
              backgroundColor: whiteColor,
              color: randomColor[Random().nextInt(randomColor.length)],
              onRefresh: () => controller.onRefereshPost(),
              child: Column(
                children: [
                  CupertinoSearchTextField(
                    onChanged: (value) => controller.searchPost(value),
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
                    child: controller.visibleList.isNotEmpty
                        ? ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.visibleList.length + 1,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index < controller.visibleList.length) {
                            var item = controller.visibleList[index];
                            return PostCardWidget(item: item);
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

