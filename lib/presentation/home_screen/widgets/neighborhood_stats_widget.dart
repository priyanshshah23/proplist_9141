import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/custom_icon_widget.dart';

class NeighborhoodStatsWidget extends StatelessWidget {
  const NeighborhoodStatsWidget({super.key});

  static const List<Map<String, dynamic>> _stats = [
    {
      'label': 'Safety Index',
      'value': '92%',
      'icon': 'security',
      'color': Color(0xFF2D7A4F),
    },
    {
      'label': 'Transport',
      'value': '8.6/10',
      'icon': 'directions_bus',
      'color': Color(0xFF1B4FD8),
    },
    {
      'label': 'Lifestyle',
      'value': '9.1/10',
      'icon': 'people',
      'color': Color(0xFFE91E8C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Neighborhood Insights',
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
        Row(
          children: _stats
              .map(
                (s) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: _stats.indexOf(s) < _stats.length - 1 ? 10 : 0,
                    ),
                    child: _StatCard(stat: s),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final Map<String, dynamic> stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconWidget(
            iconName: stat['icon'] as String,
            color: stat['color'] as Color,
            size: 22,
          ),
          const SizedBox(height: 8),
          Text(
            stat['value'] as String,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat['label'] as String,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
