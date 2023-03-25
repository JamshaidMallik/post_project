
import 'package:flutter/material.dart';
class ClipPathScreen extends StatefulWidget {
  const ClipPathScreen({Key? key}) : super(key: key);

  @override
  State<ClipPathScreen> createState() => _ClipPathScreenState();
}

class _ClipPathScreenState extends State<ClipPathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipPath(
          clipper: customClipper(),
          child: Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class customClipper extends CustomClipper<Path> {
  @override
    Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.height ,0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
