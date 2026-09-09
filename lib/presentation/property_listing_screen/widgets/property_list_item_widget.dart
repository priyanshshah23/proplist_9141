import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/status_badge_widget.dart';

class PropertyListItemWidget extends StatefulWidget {
  final Map<String, dynamic> property;
  final Duration animationDelay;

  const PropertyListItemWidget({
    super.key,
    required this.property,
    this.animationDelay = Duration.zero,
  });

  @override
  State<PropertyListItemWidget> createState() => _PropertyListItemWidgetState();
}

class _PropertyListItemWidgetState extends State<PropertyListItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(widget.animationDelay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return status == 'forRent' ? '\$$formatted/mo' : '\$$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Dismissible(
          key: Key(p['id'] as String),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFE91E8C).withAlpha(26),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'favorite',
                  color: const Color(0xFFE91E8C),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'Save',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFE91E8C),
                  ),
                ),
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            setState(() => _isSaved = true);
            return false;
          },
          child: GestureDetector(
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
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                        ),
                        child: CustomImageWidget(
                          imageUrl: p['imageUrl'] as String,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                          semanticLabel: p['semanticLabel'] as String,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: StatusBadgeWidget(status: _getStatus()),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  p['name'] as String,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1A1A2E),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _isSaved = !_isSaved),
                                child: CustomIconWidget(
                                  iconName: _isSaved
                                      ? 'favorite'
                                      : 'favorite_border',
                                  color: _isSaved
                                      ? const Color(0xFFE91E8C)
                                      : const Color(0xFFD1D5DB),
                                  size: 18,
                                ),
                              ),
                            ],
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
                            children: [
                              _specItem(
                                Icons.bed_outlined,
                                '${p['beds']} Beds',
                              ),
                              const SizedBox(width: 10),
                              _specItem(
                                Icons.bathtub_outlined,
                                '${p['baths']} Baths',
                              ),
                              const SizedBox(width: 10),
                              _specItem(
                                Icons.square_foot_rounded,
                                '${p['sqft']}',
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatPrice(
                                  p['price'] as int,
                                  p['status'] as String,
                                ),
                                style: GoogleFonts.dmSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFFE91E8C),
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'star',
                                    color: const Color(0xFFFBBF24),
                                    size: 13,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${p['rating']}',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _specItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 12, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 3),
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}
