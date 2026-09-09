import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/app_bar_widget.dart';
import '../../widgets/empty_state_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/property_list_item_widget.dart';

class PropertyListingScreen extends StatefulWidget {
  const PropertyListingScreen({super.key});

  @override
  State<PropertyListingScreen> createState() => _PropertyListingScreenState();
}

class _PropertyListingScreenState extends State<PropertyListingScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  String _selectedFilter = 'All';
  bool _isLoading = false;

  static final List<Map<String, dynamic>> _allPropertiesMaps = [
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
      'type': 'House',
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
      'type': 'Villa',
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
      'type': 'Apartment',
    },
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
      'type': 'House',
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
      'type': 'Penthouse',
    },
    {
      'id': 'p6',
      'name': 'Palm Court Apartments',
      'location': 'Culver City, CA',
      'price': 2200,
      'beds': 2,
      'baths': 2,
      'sqft': 1100,
      'rating': 4.5,
      'status': 'forRent',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_14d55466c-1767170623017.png',
      'semanticLabel':
          'Modern apartment complex with palm trees and outdoor swimming pool',
      'type': 'Apartment',
    },
    {
      'id': 'p7',
      'name': 'Cedarwood Villa',
      'location': 'Malibu, CA',
      'price': 5500,
      'beds': 5,
      'baths': 4,
      'sqft': 4200,
      'rating': 5.0,
      'status': 'forRent',
      'imageUrl':
          'https://images.unsplash.com/photo-1489460514699-c6594eb09ed3',
      'semanticLabel':
          'Oceanfront luxury villa with cedar wood facade and infinity pool',
      'type': 'Villa',
    },
    {
      'id': 'p8',
      'name': 'Harbor View Studio',
      'location': 'Long Beach, CA',
      'price': 1400,
      'beds': 0,
      'baths': 1,
      'sqft': 520,
      'rating': 4.3,
      'status': 'underOffer',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1a25dd6a4-1778150774766.png',
      'semanticLabel':
          'Compact studio apartment with harbor view and modern minimalist interior',
      'type': 'Studio',
    },
  ];

  List<Map<String, dynamic>> get _filteredProperties {
    if (_selectedFilter == 'All') return _allPropertiesMaps;
    if (_selectedFilter == 'Rent') {
      return _allPropertiesMaps.where((p) => p['status'] == 'forRent').toList();
    }
    if (_selectedFilter == 'Buy') {
      return _allPropertiesMaps.where((p) => p['status'] == 'forSale').toList();
    }
    return _allPropertiesMaps
        .where((p) => p['type'] == _selectedFilter)
        .toList();
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProperties;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          title: 'All Properties',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () => _showSortSheet(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.sort_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          FilterChipsWidget(
            selected: _selectedFilter,
            onSelected: (f) => setState(() => _selectedFilter = f),
          ),
          Expanded(
            child: filtered.isEmpty
                ? EmptyStateWidget(
                    iconName: 'home_work',
                    title: 'No properties found',
                    subtitle:
                        'Try adjusting your filters to see more properties.',
                    ctaLabel: 'Clear Filters',
                    onCta: () => setState(() => _selectedFilter = 'All'),
                  )
                : RefreshIndicator(
                    color: const Color(0xFFE91E8C),
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => PropertyListItemWidget(
                        property: filtered[index],
                        animationDelay: Duration(milliseconds: index * 60),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFilterSheet(context),
        backgroundColor: const Color(0xFFE91E8C),
        icon: const Icon(Icons.filter_list_rounded, color: Colors.white),
        label: Text(
          'Filters',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort By',
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ...[
              'Price: Low to High',
              'Price: High to Low',
              'Newest First',
              'Top Rated',
              'Closest to Me',
            ].map(
              (s) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(s, style: GoogleFonts.dmSans(fontSize: 14)),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Filters',
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Price Range',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            RangeSlider(
              values: const RangeValues(1000, 5000),
              min: 500,
              max: 10000,
              activeColor: const Color(0xFFE91E8C),
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E8C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
