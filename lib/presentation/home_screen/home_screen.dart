import 'package:flutter/material.dart';

import './widgets/featured_properties_widget.dart';
import './widgets/home_header_widget.dart';
import './widgets/neighborhood_stats_widget.dart';
import './widgets/promo_banner_widget.dart';
import './widgets/property_types_widget.dart';
import './widgets/rent_buy_toggle_widget.dart';
import './widgets/top_agents_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  bool _isRent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: HomeHeaderWidget(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RentBuyToggleWidget(
                      isRent: _isRent,
                      onToggle: (v) => setState(() => _isRent = v),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FeaturedPropertiesWidget(isRent: _isRent),
                  const SizedBox(height: 24),
                  const TopAgentsWidget(),
                  const SizedBox(height: 24),
                  const PropertyTypesWidget(),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: PromoBannerWidget(),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: NeighborhoodStatsWidget(),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
