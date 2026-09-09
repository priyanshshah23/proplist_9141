import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/custom_icon_widget.dart';

class AmenitiesGridWidget extends StatelessWidget {
  const AmenitiesGridWidget({super.key});

  static const List<Map<String, dynamic>> _amenities = [
    {'label': 'Swimming Pool', 'icon': 'pool'},
    {'label': 'Gym', 'icon': 'fitness_center'},
    {'label': 'Garden', 'icon': 'park'},
    {'label': 'Security', 'icon': 'security'},
    {'label': 'Parking', 'icon': 'local_parking'},
    {'label': 'Wifi', 'icon': 'wifi'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _amenities.length,
      itemBuilder: (context, index) {
        final amenity = _amenities[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: amenity['icon'] as String,
                color: const Color(0xFF1A1A2E),
                size: 22,
              ),
              const SizedBox(height: 5),
              Text(
                amenity['label'] as String,
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
