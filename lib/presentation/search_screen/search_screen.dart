import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/empty_state_widget.dart';
import './widgets/recent_searches_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/search_filter_widget.dart';
import './widgets/search_results_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _hasSearched = false;

  static final List<Map<String, dynamic>> _allProperties = [
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
      'semanticLabel': 'Luxury contemporary villa with pool and mountain views',
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
          'https://img.rocket.new/generatedImages/rocket_gen_img_16bc71691-1767021511546.png',
      'semanticLabel':
          'Traditional craftsman home with mature maple trees in front yard',
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

  List<Map<String, dynamic>> get _results {
    if (_query.isEmpty) return [];
    return _allProperties
        .where(
          (p) =>
              (p['name'] as String).toLowerCase().contains(
                _query.toLowerCase(),
              ) ||
              (p['location'] as String).toLowerCase().contains(
                _query.toLowerCase(),
              ) ||
              (p['type'] as String).toLowerCase().contains(
                _query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final results = _results;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Search Properties',
                style: GoogleFonts.dmSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(
                controller: _searchController,
                onChanged: (v) => setState(() {
                  _query = v;
                  _hasSearched = v.isNotEmpty;
                }),
                onClear: () => setState(() {
                  _query = '';
                  _hasSearched = false;
                  _searchController.clear();
                }),
              ),
            ),
            const SizedBox(height: 16),
            if (!_hasSearched) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RecentSearchesWidget(),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SearchFilterWidget(),
              ),
            ],
            if (_hasSearched) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${results.length} propert${results.length == 1 ? 'y' : 'ies'} found',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Expanded(
              child: _hasSearched
                  ? results.isEmpty
                        ? EmptyStateWidget(
                            iconName: 'search_off',
                            title: 'No properties found',
                            subtitle:
                                'Try searching by neighborhood, city, or property type.',
                            ctaLabel: 'Clear Search',
                            onCta: () => setState(() {
                              _query = '';
                              _hasSearched = false;
                              _searchController.clear();
                            }),
                          )
                        : SearchResultsWidget(
                            results: results,
                            isTablet: isTablet,
                          )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
