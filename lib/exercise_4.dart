import 'package:flutter/material.dart';

class Exercise4 extends StatelessWidget {
  const Exercise4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 - Primitive Shapes'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: CustomPaint(painter: PrimitivePainter()),
      )
    );
  }
}

class PrimitivePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    final p = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 4.0
        ..color = Colors.indigo;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(70, 20, 200, 100), Radius.circular(0)),
      p,
    );

    canvas.drawCircle(Offset(95, 145), 25, p);
    canvas.drawCircle(Offset(245, 145), 25, p);

    var path = Path();
    path.moveTo(167.5, 250);
    path.lineTo(0, 500);
    path.lineTo(335, 500);
    path.close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(PrimitivePainter oldDelegate) => false;
}