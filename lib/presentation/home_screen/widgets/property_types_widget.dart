import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_icon_widget.dart';

class PropertyTypesWidget extends StatelessWidget {
  const PropertyTypesWidget({super.key});

  static const List<Map<String, dynamic>> _types = [
    {'label': 'Apartment', 'icon': 'apartment'},
    {'label': 'Villa', 'icon': 'villa'},
    {'label': 'House', 'icon': 'home'},
    {'label': 'Studio', 'icon': 'meeting_room'},
    {'label': 'Penthouse', 'icon': 'roofing'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Property Types',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _types.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final type = _types[index];
              return GestureDetector(
                onTap: () => context.go(AppRoutes.propertyListingScreen),
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: type['icon'] as String,
                        color: const Color(0xFFE91E8C),
                        size: 26,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        type['label'] as String,
                        style: GoogleFonts.dmSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A2E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
