import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertySpecsRowWidget extends StatelessWidget {
  final Map<String, dynamic> property;
  const PropertySpecsRowWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final specs = [
      {
        'icon': Icons.bed_outlined,
        'value': '${property['beds'] ?? 0}',
        'label': 'Beds',
      },
      {
        'icon': Icons.bathtub_outlined,
        'value': '${property['baths'] ?? 0}',
        'label': 'Baths',
      },
      {
        'icon': Icons.square_foot_rounded,
        'value': '${property['sqft'] ?? 0}',
        'label': 'Sqft',
      },
      {
        'icon': Icons.star_rounded,
        'value': '${property['rating'] ?? 0}',
        'label': 'Rating',
      },
    ];

    return Row(
      children: specs.map((spec) {
        final isLast = specs.indexOf(spec) == specs.length - 1;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: isLast ? 0 : 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                Icon(
                  spec['icon'] as IconData,
                  size: 18,
                  color: const Color(0xFFE91E8C),
                ),
                const SizedBox(height: 4),
                Text(
                  spec['value'] as String,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  spec['label'] as String,
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
