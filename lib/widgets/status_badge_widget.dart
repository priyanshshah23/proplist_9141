import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum PropertyStatus { forRent, forSale, underOffer, sold }

class StatusBadgeWidget extends StatelessWidget {
  final PropertyStatus status;

  const StatusBadgeWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;
    String label;

    switch (status) {
      case PropertyStatus.forRent:
        bg = const Color(0xFFE91E8C);
        text = Colors.white;
        label = 'FOR RENT';
        break;
      case PropertyStatus.forSale:
        bg = const Color(0xFF1B4FD8);
        text = Colors.white;
        label = 'FOR SALE';
        break;
      case PropertyStatus.underOffer:
        bg = const Color(0xFFB45309);
        text = Colors.white;
        label = 'UNDER OFFER';
        break;
      case PropertyStatus.sold:
        bg = const Color(0xFF6B7280);
        text = Colors.white;
        label = 'SOLD';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
