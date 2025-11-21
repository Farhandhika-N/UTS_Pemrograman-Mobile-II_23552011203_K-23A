import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HobbyCard extends StatefulWidget {
  final String hobby;
  final IconData? iconData;

  const HobbyCard({
    super.key,
    required this.hobby,
    this.iconData,
  });

  @override
  State<HobbyCard> createState() => _HobbyCardState();
}

class _HobbyCardState extends State<HobbyCard> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  IconData _getIconForHobby(String hobbyName) {
    final name = hobbyName.toLowerCase();
    
    if (name.contains('film') || name.contains('movie') || name.contains('bioskop')) {
      return Icons.local_movies_outlined; 
    } else if (name.contains('musik') || name.contains('audio') || name.contains('lagu')) {
      return Icons.library_music_outlined; 
    } else if (name.contains('ikan') || name.contains('pelihara') || name.contains('aquarium')) {
      return Icons.set_meal;
    } else if (name.contains('game') || name.contains('main')) {
      return Icons.sports_esports_outlined;
    } else {
      return Icons.star_border_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final accentColor = theme.primaryColor;

    final icon = widget.iconData ?? _getIconForHobby(widget.hobby);

    final baseCardColor = isDark 
        ? theme.colorScheme.surface.withOpacity(0.9) 
        : Colors.white;

    final interactiveCardColor = _isPressed
        ? accentColor.withOpacity(isDark ? 0.1 : 0.05) 
        : baseCardColor;

    final textColor = isDark ? Colors.white : Colors.black87;
    final iconColor = accentColor;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150), 
        curve: Curves.easeInOut,

        decoration: BoxDecoration(
          color: interactiveCardColor,
          borderRadius: BorderRadius.circular(10.0), 
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : Colors.grey.shade400).withOpacity(_isPressed ? 0.5 : 0.2),
              blurRadius: _isPressed ? 8 : 4,
              offset: Offset(0, _isPressed ? 4 : 1), 
            ),
          ],
        ),
        
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 5.0, 
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.hobby,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600, 
                          color: textColor, 
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(width: 8.0),

                    Icon(
                      icon,
                      size: 24.0,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}