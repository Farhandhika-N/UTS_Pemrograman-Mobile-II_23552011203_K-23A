import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlinkingStatus extends StatefulWidget {
  final String statusText;
  final Color statusColor;

  const BlinkingStatus({
    super.key,
    required this.statusText,
    required this.statusColor,
  });

  @override
  State<BlinkingStatus> createState() => _BlinkingStatusState();
}

class _BlinkingStatusState extends State<BlinkingStatus> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.statusColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5),
          ],
        ),
        child: Text(
          'STATUS: ${widget.statusText.toUpperCase()}',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}