import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_image_widget.dart';

class SimilarPropertiesRowWidget extends StatelessWidget {
  const SimilarPropertiesRowWidget({super.key});

  static const List<Map<String, dynamic>> _similar = [
    {
      'id': 'sp1',
      'price': 2800,
      'status': 'forRent',
      'imageUrl':
          'https://images.unsplash.com/photo-1727145973393-80729cea2155',
      'semanticLabel':
          'Modern apartment complex with palm trees and outdoor pool at dusk',
      'name': 'Palm Court',
      'location': 'Culver City, CA',
      'beds': 2,
      'baths': 2,
      'sqft': 1100,
      'rating': 4.5,
    },
    {
      'id': 'sp2',
      'price': 3100,
      'status': 'forRent',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1036a2f0f-1775715485823.png',
      'semanticLabel':
          'Oceanfront luxury villa with cedar wood facade and infinity pool at sunset',
      'name': 'Cedarwood Villa',
      'location': 'Malibu, CA',
      'beds': 5,
      'baths': 4,
      'sqft': 4200,
      'rating': 5.0,
    },
    {
      'id': 'sp3',
      'price': 2700,
      'status': 'forRent',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1a6b09e54-1766169068321.png',
      'semanticLabel':
          'Contemporary hillside villa with large glass walls and mountain backdrop',
      'name': 'Ridge House',
      'location': 'Bel Air, CA',
      'beds': 3,
      'baths': 2,
      'sqft': 2200,
      'rating': 4.7,
    },
  ];

  String _formatPrice(int price) {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '\$$formatted/mo';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _similar.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final p = _similar[index];
          return GestureDetector(
            onTap: () => context.push(AppRoutes.propertyDetailScreen, extra: p),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CustomImageWidget(
                    imageUrl: p['imageUrl'] as String,
                    width: 110,
                    height: 130,
                    fit: BoxFit.cover,
                    semanticLabel: p['semanticLabel'] as String,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(14),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withAlpha(179),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Text(
                      _formatPrice(p['price'] as int),
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
