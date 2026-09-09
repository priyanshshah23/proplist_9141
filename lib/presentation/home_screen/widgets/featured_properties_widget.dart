import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import './property_card_widget.dart';

class FeaturedPropertiesWidget extends StatelessWidget {
  final bool isRent;
  const FeaturedPropertiesWidget({super.key, required this.isRent});

  static final List<Map<String, dynamic>> _rentProperties = [
    {
      'id': 'p1',
      'name': 'Sunflower Haven',
      'location': 'Santa Monica, CA',
      'price': 2900,
      'beds': 3,
      'baths': 2,
      'sqft': 1850,
      'rating': 4.8,
      'status': 'forRent',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_179044397-1777680752499.png',
      'semanticLabel':
          'Modern two-story house with large windows and green garden at sunset',
    },
    {
      'id': 'p2',
      'name': 'Hillside Haven',
      'location': 'Beverly Hills, CA',
      'price': 3800,
      'beds': 4,
      'baths': 3,
      'sqft': 2800,
      'rating': 4.9,
      'status': 'forRent',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_119bb1cdb-1765061397260.png',
      'semanticLabel':
          'Luxury contemporary villa with pool and mountain views in hillside setting',
    },
    {
      'id': 'p3',
      'name': 'Urban Loft 42',
      'location': 'Downtown LA, CA',
      'price': 1950,
      'beds': 1,
      'baths': 1,
      'sqft': 780,
      'rating': 4.6,
      'status': 'forRent',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1fee46aaa-1772134652889.png',
      'semanticLabel':
          'Industrial style studio loft with exposed brick walls and city skyline view',
    },
  ];

  static final List<Map<String, dynamic>> _buyProperties = [
    {
      'id': 'p4',
      'name': 'Maple Grove Estate',
      'location': 'Pasadena, CA',
      'price': 875000,
      'beds': 4,
      'baths': 3,
      'sqft': 3200,
      'rating': 4.7,
      'status': 'forSale',
      'imageUrl':
          'https://images.unsplash.com/photo-1732359882569-a4cc44273bc7',
      'semanticLabel':
          'Traditional American craftsman home with mature maple trees in front yard',
    },
    {
      'id': 'p5',
      'name': 'Azure Penthouse',
      'location': 'West Hollywood, CA',
      'price': 1250000,
      'beds': 3,
      'baths': 2,
      'sqft': 2100,
      'rating': 4.9,
      'status': 'forSale',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_14bff150c-1770926755793.png',
      'semanticLabel':
          'Luxury penthouse rooftop terrace with panoramic city lights at night',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final properties = isRent ? _rentProperties : _buyProperties;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isRent ? 'Featured Rentals' : 'Properties for Sale',
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              GestureDetector(
                onTap: () => context.go(AppRoutes.propertyListingScreen),
                child: Text(
                  'SEE ALL',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFE91E8C),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: properties.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) => PropertyCardWidget(
              property: properties[index],
              isHorizontal: true,
            ),
          ),
        ),
      ],
    );
  }
}
