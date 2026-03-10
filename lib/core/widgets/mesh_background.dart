import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class MeshBackground extends StatefulWidget {
  final List<Color> colors;
  final Color? baseColor;
  final Widget? child;

  const MeshBackground({
    super.key,
    this.colors = const [
      Color(0xFF1E3A8A), // Deep Blue
      Color(0xFF2563EB), // Primary Blue
      Color(0xFF3B82F6), // Sky Blue
      Color(0xFF1D4ED8), // Dark Blue
    ],
    this.baseColor,
    this.child,
  });

  @override
  State<MeshBackground> createState() => _MeshBackgroundState();
}

class _MeshBackgroundState extends State<MeshBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Base background
            Container(
              color:
                  widget.baseColor ?? Theme.of(context).scaffoldBackgroundColor,
            ),

            // Animated blobs with lower opacity for professional blending
            _buildBlob(
              top: -100 + 150 * math.sin(_controller.value * 2 * math.pi),
              left: -100 + 120 * math.cos(_controller.value * 2 * math.pi),
              color: widget.colors[0].withOpacity(0.25),
              size: 900,
            ),
            _buildBlob(
              bottom: -150 + 180 * math.cos(_controller.value * 2 * math.pi),
              right: -100 + 130 * math.sin(_controller.value * 2 * math.pi),
              color: widget.colors[1].withOpacity(0.2),
              size: 1000,
            ),
            _buildBlob(
              top: 200 + 150 * math.sin(_controller.value * 2 * math.pi + 1),
              right: 100 + 150 * math.cos(_controller.value * 2 * math.pi + 1),
              color: widget.colors[2].withOpacity(0.18),
              size: 800,
            ),
            _buildBlob(
              bottom: 150 + 120 * math.sin(_controller.value * 2 * math.pi + 2),
              left: 200 + 130 * math.cos(_controller.value * 2 * math.pi + 2),
              color: widget.colors[widget.colors.length > 3 ? 3 : 0]
                  .withOpacity(0.15),
              size: 850,
            ),

            // Blur filter - increased to 100 for smoother "Mesh" transition
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),

            // Custom Noise Overlay for "Soul" and Texture
            Positioned.fill(
              child: Opacity(
                opacity: 0.045,
                child: CustomPaint(painter: NoisePainter()),
              ),
            ),

            // Subtle Vignette
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.25),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),

            if (widget.child != null) widget.child!,
          ],
        );
      },
    );
  }

  Widget _buildBlob({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required Color color,
    required double size,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
        ),
      ),
    );
  }
}

class NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random(42);
    for (int i = 0; i < 15000; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.5);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        0.4,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
