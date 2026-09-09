import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/status_badge_widget.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> results;
  final bool isTablet;

  const SearchResultsWidget({
    super.key,
    required this.results,
    required this.isTablet,
  });

  PropertyStatus _getStatus(String status) {
    switch (status) {
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
    if (isTablet) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: results.length,
        itemBuilder: (context, index) => _buildCard(context, results[index]),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildCard(context, results[index]),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> p) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.propertyDetailScreen, extra: p),
      child: Container(
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
                    height: 140,
                    fit: BoxFit.cover,
                    semanticLabel: p['semanticLabel'] as String,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: StatusBadgeWidget(
                    status: _getStatus(p['status'] as String),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] as String,
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
                      Text(
                        _formatPrice(p['price'] as int, p['status'] as String),
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFE91E8C),
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: const Color(0xFFFBBF24),
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${p['rating']}',
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
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
}
