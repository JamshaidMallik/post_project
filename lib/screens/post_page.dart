import 'dart:math';
import 'package:flutter/material.dart';
import 'package:post_project/screens/clip_path.dart';
import 'package:post_project/screens/post_detail.dart';
import '../constant/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';
import 'my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostClass post = PostClass();
  List<PostClass> postList = [];
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int limit = 13;
final ScrollController _scrollController = ScrollController();
  Future fetchPost() async{
    isLoading = true;
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page'));
    if(response.statusCode == 200){
      final newList = jsonDecode(response.body);
      setState(() {
        page++;
        if(newList.length < limit){
          hasMore = false;
        }
        newList.forEach((element) {
          post = PostClass.fromJson(element);
          postList.add(post);
        });
      });
      isLoading = false;
    }else{
      isLoading = false;
    }
  }
  _scrollListener() {
    if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
      setState(() {
        fetchPost();
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchPost();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Posts', style: bigFontStyle(),),
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
          onRefresh: () async{
           await Future.delayed(const Duration(seconds: 2));
            setState(() {
              postList.clear();
              page = 1;
              hasMore = true;
              fetchPost();
            });
          },
          child: Scrollbar(
            child: ListView.builder(
              controller: _scrollController,
                itemCount: postList.length + 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
                  if(index < postList.length){
                    var item = postList[index];
                    return Card(
                      elevation: 4.0,
                      borderOnForeground: true,
                      semanticContainer: true,
                      shadowColor: randomColor[Random().nextInt(randomColor.length)],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PostDetail(item: item,)));
                          },
                          title: Text(item.title.toString().toUpperCase(), style: secondaryFontStyle(fontWeight: FontWeight.bold,fontSize: 12.0),overflow: TextOverflow.ellipsis, maxLines: 2,),
                          subtitle: Column(
                            children: [
                              Align(
                                  alignment:  Alignment.topRight,
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                      elevation: 5.0,
                                      shadowColor: randomColor[Random().nextInt(randomColor.length)],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item.id.toString(), style: greyFontStyle(fontWeight: FontWeight.w600,fontSize: 12.0,).copyWith(color: randomColor[Random().nextInt(randomColor.length)]),overflow: TextOverflow.ellipsis, maxLines: 4,),
                                      ))),
                              Text(item.body.toString(), style: greyFontStyle(fontWeight: FontWeight.w600,fontSize: 12.0),overflow: TextOverflow.ellipsis, maxLines: 4,),
                              const Divider(),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  }else{
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(child: hasMore ? CircularProgressIndicator(color: randomColor[Random().nextInt(randomColor.length)]) : const  Text('has no more data') ),
                    );
                  }
            }),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
  List randomColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.teal,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
}


