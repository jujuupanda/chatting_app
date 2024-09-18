import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonPositive extends StatelessWidget {
  const ButtonPositive({
    super.key,
    required this.name,
    required this.function,
    this.width
  });

  final String name;
  final VoidCallback function;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: function,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
