import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white12,
        body: Center(
          child: Circular_app(),
        ),
      ),
    );
  }
}

final Gradient gradient = LinearGradient(
    colors:<Color>[
      Colors.greenAccent.withOpacity(1.0),
      Colors.yellowAccent.withOpacity(1.0),
      Colors.redAccent.withOpacity(1.0),
    ],
    stops: [
      0.0,
      0.5,
      1.0,
    ],
);


class Circular_app extends StatefulWidget {
  const Circular_app({Key? key}) : super(key: key);

  @override
  _Circular_appState createState() => _Circular_appState();
}

class _Circular_appState extends State<Circular_app> with SingleTickerProviderStateMixin {

 late Animation<double> animation;
 late AnimationController animController;

@override
  void initState() {
    super.initState();

    animController = AnimationController(duration: Duration(seconds: 3), vsync: this);

    final curvedAnimation = CurvedAnimation(parent : animController , curve: Curves.easeInCubic);

    animation = Tween<double>(begin: 0.0, end: 3.14).animate(curvedAnimation)..addListener(() {
      setState(() {

      });
    });

    animController.repeat(reverse: false);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            CustomPaint(
            size: Size(300,300),
              painter: ProgressArc(null,Colors.black54, true),
            ),
            CustomPaint(
              size: Size(300,300),
              painter: ProgressArc(animation.value,Colors.redAccent, false) ,
            ),
            Positioned(
              top: 120,
              left: 130,
              child: Text("${(animation.value/3.14 * 100).round()}%",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
    );
  }
}

class ProgressArc extends CustomPainter{

  bool isBrackground;
  var arc;
  Color progressColor;

  ProgressArc(this.arc,this.progressColor,this.isBrackground);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, 300, 300);
    final startAngle = -pi;
    final sweepAngle = arc != null ? arc : pi;
    final useCenter = false;
    final paint = Paint()
    ..strokeCap = StrokeCap.round
    ..color = progressColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;

    if(!isBrackground){
      paint.shader = gradient.createShader(rect);
    }
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}
