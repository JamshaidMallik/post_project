import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/screens/post_detail.dart';
import '../constant/constant.dart';
import '../controller/post_controller.dart';

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
              child: ListView.builder(
                  controller: postController.scrollController,
                  itemCount: postController.postList.length + 1,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < postController.postList.length) {
                      var item = postController.postList[index];
                      return Card(
                        elevation: 4.0,
                        borderOnForeground: true,
                        semanticContainer: true,
                        shadowColor:
                            randomColor[Random().nextInt(randomColor.length)],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetail(
                                            item: item,
                                          )));
                            },
                            title: Text(
                              item.title.toString().toUpperCase(),
                              style: secondaryFontStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            subtitle: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        elevation: 5.0,
                                        shadowColor: randomColor[Random()
                                            .nextInt(randomColor.length)],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            item.id.toString(),
                                            style: greyFontStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0,
                                            ).copyWith(
                                                color: randomColor[Random()
                                                    .nextInt(
                                                        randomColor.length)]),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                          ),
                                        ))),
                                Text(
                                  item.body.toString(),
                                  style: greyFontStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                                const Divider(),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                            child: postController.hasMore
                                ? CircularProgressIndicator(
                                    color: randomColor[
                                        Random().nextInt(randomColor.length)])
                                : const Text('has no more data')),
                      );
                    }
                  }),
            ),
          );
        });
  }
}
