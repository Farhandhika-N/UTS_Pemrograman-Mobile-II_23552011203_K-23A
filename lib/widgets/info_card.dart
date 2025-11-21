import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const InfoCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = theme.scaffoldBackgroundColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: isDark ? Colors.black54 : Colors.grey.shade400,
                      offset: const Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: isDark ? Colors.white10 : Colors.white,
                      offset: const Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: isDark ? Colors.black54 : Colors.grey.shade300,
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: isDark ? Colors.white10 : Colors.white,
                      offset: const Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
          ),
          child: Row(
            children: <Widget>[
              Icon(
                widget.icon,
                color: theme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}