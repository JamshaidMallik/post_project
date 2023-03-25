import 'dart:math';
import 'package:flutter/material.dart';
import '../constant/constant.dart';
import '../screens/post_detail.dart';

Card postCardWidget(BuildContext context, item) {
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
