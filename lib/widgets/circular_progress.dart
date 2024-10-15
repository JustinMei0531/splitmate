import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double progress; // Percentage of progress (0.0 to 1.0)
  final String label;

  CircularProgress({required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: CustomPaint(
        size: const Size(15, 15), // Size of the canvas
        painter: CircularProgressPainter(progress),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    double lineWidth = 5.0;
    Paint backgroundCircle = Paint()
      ..color = Colors.orange.withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    Paint foregroundCircle = Paint()
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - lineWidth) / 2;

    canvas.drawCircle(center, radius, backgroundCircle);

    double sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -3.141592653589793 / 2, sweepAngle, false, foregroundCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
