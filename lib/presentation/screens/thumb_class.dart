import 'package:flutter/material.dart';

class CustomSliderThumb extends SliderComponentShape {
  final double displayValue;
  final bool isDragging;

  CustomSliderThumb({required this.displayValue, required this.isDragging});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(50, 60);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    if (isDragging) {
      // Convert displayValue to one decimal place
      String valueText = displayValue.toStringAsFixed(1);

      final TextSpan span = TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        text: valueText,
      );

      final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: textDirection,
      );
      tp.layout();

      // bubble size
      const double padding = 12.0;
      final double rectWidth = tp.width + padding * 2;
      final double rectHeight = tp.height + padding * 0.9;
      final double pointerHeight = 10.0;

      // bubble rectangle
      final Rect rect = Rect.fromLTWH(
        center.dx - rectWidth / 2,
        center.dy - 55,
        rectWidth,
        rectHeight,
      );

      // bubble shape with sharp bottom pointer
      final Path path = Path()
        ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12))) // Rounded rectangle
        ..moveTo(center.dx - 5, rect.bottom)
        ..lineTo(center.dx, rect.bottom + pointerHeight)
        ..lineTo(center.dx + 5, rect.bottom)
        ..close();

      // bubble
      final Paint bubblePaint = Paint()..color = Colors.white;
      canvas.drawPath(path, bubblePaint);

      tp.paint(
          canvas,
          Offset(center.dx - tp.width / 2,
              rect.top + (rectHeight - tp.height) / 2));
      // // text inside bubble
      // final Offset textOffset = Offset(
      //   center.dx - tp.width / 2,
      //   rect.top + (rectHeight - tp.height) / 2,
      // );
      // tp.paint(canvas, textOffset);
    }

    // thumb
    final Paint thumbPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 10.0, thumbPaint);
  }
}
