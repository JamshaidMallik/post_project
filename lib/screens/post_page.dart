import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/screens/post_detail.dart';
import '../constant/constant.dart';
import '../controller/post_controller.dart';
import 'my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (postController) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: whiteColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Posts',
                style: bigFontStyle(),
              ),
            ),
            body: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _scaffoldKey.currentState?.openDrawer();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _scaffoldKey.currentState?.openEndDrawer();
                }
              },
              child: RefreshIndicator(
                backgroundColor: whiteColor,
                color: randomColor[Random().nextInt(randomColor.length)],
                onRefresh: () => postController.onRefereshPost(),
                child: Scrollbar(
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
                            shadowColor: randomColor[
                                Random().nextInt(randomColor.length)],
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
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
                                                    BorderRadius.circular(
                                                        50.0)),
                                            elevation: 5.0,
                                            shadowColor: randomColor[Random()
                                                .nextInt(randomColor.length)],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                item.id.toString(),
                                                style: greyFontStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                ).copyWith(
                                                    color: randomColor[Random()
                                                        .nextInt(randomColor
                                                            .length)]),
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
                                        color: randomColor[Random()
                                            .nextInt(randomColor.length)])
                                    : const Text('has no more data')),
                          );
                        }
                      }),
                ),
              ),
            ),
            drawer: MyDrawer(),
          );
        });
  }
}
