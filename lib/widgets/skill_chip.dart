import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final chipColor = theme.colorScheme.secondary.withOpacity(isDark ? 0.2 : 0.8);
    
    final textColor = isDark ? Colors.white : Colors.black;

    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      backgroundColor: chipColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1.5,
        ),
      ),
      label: Text(
        skill,
        style: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}