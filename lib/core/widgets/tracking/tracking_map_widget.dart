import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/model/tracking_data.dart';

class TrackingMapWidget extends StatelessWidget {
  final TrackingData data;

  const TrackingMapWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;
      final carPos = Offset(w * data.carRelX, h * data.carRelY);
      final destPos = Offset(w * data.destRelX, h * data.destRelY);
      final routeEnd = Offset(w * 0.92, h * 0.08);

      return Stack(
        children: [
          CustomPaint(
            size: Size(w, h),
            painter: _MapPainter(carPos: carPos, routeEnd: routeEnd),
          ),
          Positioned(
            left: carPos.dx - 20,
            top: carPos.dy - 18,
            child: const Text('🚗', style: TextStyle(fontSize: 36)),
          ),
          Positioned(
            left: destPos.dx - 16,
            top: destPos.dy - 16,
            child: const _DestinationMarker(),
          ),
        ],
      );
    });
  }
}

class _MapPainter extends CustomPainter {
  final Offset carPos;
  final Offset routeEnd;

  const _MapPainter({required this.carPos, required this.routeEnd});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF0D1828),
    );

    final gridPaint = Paint()
      ..color = const Color(0xFF1A2840)
      ..strokeWidth = 0.6;
    const spacing = 28.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    canvas.drawLine(
      carPos,
      routeEnd,
      Paint()
        ..color = AppColors.brandGold
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _MapPainter old) =>
      old.carPos != carPos || old.routeEnd != routeEnd;
}

class _DestinationMarker extends StatelessWidget {
  const _DestinationMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.brandGold, width: 2),
        color: const Color(0xFF0D1828),
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.brandGold,
          ),
        ),
      ),
    );
  }
}
