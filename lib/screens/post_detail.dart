import 'package:flutter/material.dart';
import 'package:post_project/model/post_model.dart';

import '../constant/constant.dart';

class PostDetail extends StatelessWidget {
   PostClass item;
   PostDetail({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Post Detail', style: bigFontStyle(),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.title}'.toUpperCase(), style: secondaryFontStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('${item.body}', style: greyFontStyle(fontSize: 12.0, fontWeight: FontWeight.w600),textAlign: TextAlign.start,softWrap: true, ),
          ],
        ),
      )
    );
  }
}
