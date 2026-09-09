import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/status_badge_widget.dart';

class PropertyCardWidget extends StatefulWidget {
  final Map<String, dynamic> property;
  final bool isHorizontal;

  const PropertyCardWidget({
    super.key,
    required this.property,
    this.isHorizontal = false,
  });

  @override
  State<PropertyCardWidget> createState() => _PropertyCardWidgetState();
}

class _PropertyCardWidgetState extends State<PropertyCardWidget> {
  bool _isSaved = false;

  PropertyStatus _getStatus() {
    switch (widget.property['status'] as String) {
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
    if (status == 'forRent') {
      return '\$${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}/mo';
    }
    return '\$${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    final isHoriz = widget.isHorizontal;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.propertyDetailScreen, extra: p),
      child: Container(
        width: isHoriz ? 200 : double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: CustomImageWidget(
                    imageUrl: p['imageUrl'] as String,
                    width: double.infinity,
                    height: isHoriz ? 140 : 160,
                    fit: BoxFit.cover,
                    semanticLabel: p['semanticLabel'] as String,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: StatusBadgeWidget(status: _getStatus()),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _isSaved = !_isSaved),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName: _isSaved ? 'favorite' : 'favorite_border',
                          color: _isSaved
                              ? const Color(0xFFE91E8C)
                              : const Color(0xFF9CA3AF),
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] as String,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'location_on',
                        color: const Color(0xFF9CA3AF),
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          p['location'] as String,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: const Color(0xFF9CA3AF),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _formatPrice(
                            p['price'] as int,
                            p['status'] as String,
                          ),
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFE91E8C),
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                      if (!isHoriz) ...[
                        _specChip(Icons.bed_outlined, '${p['beds']}'),
                        const SizedBox(width: 6),
                        _specChip(Icons.bathtub_outlined, '${p['baths']}'),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _specChip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 11, color: const Color(0xFF6B7280)),
          const SizedBox(width: 3),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
