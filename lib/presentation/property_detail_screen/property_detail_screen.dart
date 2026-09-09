import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/custom_image_widget.dart';
import '../../widgets/status_badge_widget.dart';
import './widgets/amenities_grid_widget.dart';
import './widgets/owner_contact_pill_widget.dart';
import './widgets/property_specs_row_widget.dart';
import './widgets/similar_properties_row_widget.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Map<String, dynamic> property;
  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  bool _isSaved = false;

  PropertyStatus _getStatus() {
    switch (widget.property['status'] as String? ?? 'forRent') {
      case 'forRent':
        return PropertyStatus.forRent;
      case 'forSale':
        return PropertyStatus.forSale;
      case 'underOffer':
        return PropertyStatus.underOffer;
      default:
        return PropertyStatus.sold;
    }
  }

  String _formatPrice(int price, String status) {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return status == 'forRent' ? '\$$formatted/month' : '\$$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    final status = p['status'] as String? ?? 'forRent';
    final price = p['price'] as int? ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Hero(
                      tag: 'property-image-${p['id']}',
                      child: CustomImageWidget(
                        imageUrl: p['imageUrl'] as String? ?? '',
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                        semanticLabel:
                            p['semanticLabel'] as String? ?? 'Property image',
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(38),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 18,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _shareProperty,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(38),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.share_rounded,
                                        size: 18,
                                        color: Color(0xFF1A1A2E),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        setState(() => _isSaved = !_isSaved),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(38),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: CustomIconWidget(
                                          iconName: _isSaved
                                              ? 'favorite'
                                              : 'favorite_border',
                                          color: _isSaved
                                              ? const Color(0xFFE91E8C)
                                              : const Color(0xFF6B7280),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 16,
                      child: StatusBadgeWidget(status: _getStatus()),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                p['name'] as String? ?? 'Property',
                                style: GoogleFonts.dmSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1A1A2E),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _formatPrice(price, status),
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE91E8C),
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'location_on',
                              color: const Color(0xFFE91E8C),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              p['location'] as String? ?? '',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        PropertySpecsRowWidget(property: p),
                        const SizedBox(height: 20),
                        Text(
                          'Description',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This exceptional property offers a perfect blend of modern architecture and natural beauty. The spacious living areas are adorned with large windows that frame breathtaking views. Premium finishes throughout, including hardwood floors, chef\'s kitchen with stone countertops, and resort-style bathrooms. The expansive outdoor space features a beautifully landscaped garden and entertainment areas perfect for California living.',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: const Color(0xFF6B7280),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const OwnerContactPillWidget(),
                        const SizedBox(height: 24),
                        Text(
                          'Amenities',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const AmenitiesGridWidget(),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Similar Properties',
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A2E),
                              ),
                            ),
                            Text(
                              'SEE ALL',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFE91E8C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const SimilarPropertiesRowWidget(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () =>
                      context.push(AppRoutes.checkoutScreen, extra: p),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A1A2E),
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFF1A1A2E), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'SCHEDULE A TOUR',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareProperty() {
    final p = widget.property;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing ${p['name']} — \$${p['price']}/mo at ${p['location']}',
          style: GoogleFonts.dmSans(fontSize: 13),
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Copy Link',
          textColor: const Color(0xFFE91E8C),
          onPressed: () {},
        ),
      ),
    );
  }
}
