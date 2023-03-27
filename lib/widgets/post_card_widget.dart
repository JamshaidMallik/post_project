import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/controller/post_controller.dart';
import '../constant/constant.dart';
import '../model/post_model.dart';
import '../screens/post_detail.dart';

class PostCardWidget extends GetView<PostController> {
  final PostClass item;
  const PostCardWidget({Key? key, required this.item}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PostController(),
      builder: (ctr) {
        return Card(
          elevation: 4.0,
          borderOnForeground: true,
          semanticContainer: true,
          shadowColor: randomColor[Random().nextInt(randomColor.length)],
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
              leading: Checkbox(
                value: item.isSelected,
                onChanged: (value) {
                  controller.selectItem(item, value!);
                },
              ),
              title: Text(
                item.title.toString().toUpperCase(),
                style:
                secondaryFontStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          elevation: 5.0,
                          shadowColor:
                          randomColor[Random().nextInt(randomColor.length)],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.id.toString(),
                              style: greyFontStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ).copyWith(
                                  color: randomColor[
                                  Random().nextInt(randomColor.length)]),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                          ))),
                  Text(
                    item.body.toString(),
                    style: greyFontStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
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
      }
    );
  }
}


class SelectedPostsScreen extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Posts'),
      ),
      body:GetBuilder(
        init: PostController(),
        builder: (myController) {
           final selectedPosts = controller.selectedPostList.toList();
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
class PostCardWidget1 extends StatelessWidget {
  final PostClass item;
  final bool isSelected;
  final VoidCallback? onTap;

  const PostCardWidget1({
    Key? key,
    required this.item,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      borderOnForeground: true,
      semanticContainer: true,
      shadowColor: randomColor[Random().nextInt(randomColor.length)],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: onTap != null
              ? () {
            onTap!();
          }
              : null,
          leading: Checkbox(
            value: isSelected,
            onChanged: (value) {
              // Do nothing
            },
          ),
          title: Text(
            item.title.toString().toUpperCase(),
            style: secondaryFontStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.id.toString(),
                      style: greyFontStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ).copyWith(
                        color:
                        randomColor[Random().nextInt(randomColor.length)],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              Text(
                item.body.toString(),
                style: greyFontStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
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
  }
}
