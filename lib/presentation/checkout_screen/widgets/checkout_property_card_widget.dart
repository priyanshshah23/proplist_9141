import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/status_badge_widget.dart';

class CheckoutPropertyCardWidget extends StatelessWidget {
  final Map<String, dynamic> property;
  const CheckoutPropertyCardWidget({super.key, required this.property});

  PropertyStatus _getStatus() {
    switch (property['status'] as String? ?? 'forRent') {
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
    return status == 'forRent' ? '\$$formatted/mo' : '\$$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final p = property;
    final price = p['price'] as int? ?? 0;
    final status = p['status'] as String? ?? 'forRent';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            child: CustomImageWidget(
              imageUrl: p['imageUrl'] as String? ?? '',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              semanticLabel: p['semanticLabel'] as String? ?? 'Property image',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusBadgeWidget(status: _getStatus()),
                  const SizedBox(height: 6),
                  Text(
                    p['name'] as String? ?? 'Property',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
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
                          p['location'] as String? ?? '',
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
                  const SizedBox(height: 6),
                  Text(
                    _formatPrice(price, status),
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFE91E8C),
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
