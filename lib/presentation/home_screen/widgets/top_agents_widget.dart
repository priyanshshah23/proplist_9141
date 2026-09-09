import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';

class TopAgentsWidget extends StatelessWidget {
  const TopAgentsWidget({super.key});

  static const List<Map<String, dynamic>> _agents = [
    {
      'name': 'Dianne Russell',
      'rating': 4.9,
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_19dd7eb8c-1763293980389.png',
      'semanticLabel':
          'Professional headshot of Hispanic woman with shoulder-length brown hair in business attire',
    },
    {
      'name': 'Floyd Miles',
      'rating': 4.8,
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1ffe872cd-1763294679798.png',
      'semanticLabel':
          'Professional headshot of Black man with short hair in dark suit and tie',
    },
    {
      'name': 'Courtney Henry',
      'rating': 4.9,
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_10d60e496-1763295319842.png',
      'semanticLabel':
          'Professional headshot of Asian woman with long black hair in white blouse',
    },
    {
      'name': 'Darrell Steward',
      'rating': 4.7,
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1c7263203-1763291891265.png',
      'semanticLabel':
          'Professional headshot of Middle Eastern man with beard in grey suit',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Estate Agents',
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
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 90,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _agents.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (context, index) =>
                _AgentAvatarWidget(agent: _agents[index]),
          ),
        ),
      ],
    );
  }
}

class _AgentAvatarWidget extends StatelessWidget {
  final Map<String, dynamic> agent;
  const _AgentAvatarWidget({required this.agent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE91E8C), width: 2),
          ),
          child: ClipOval(
            child: CustomImageWidget(
              imageUrl: agent['imageUrl'] as String,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              semanticLabel: agent['semanticLabel'] as String,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          (agent['name'] as String).split(' ').first,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'star',
              color: const Color(0xFFFBBF24),
              size: 10,
            ),
            const SizedBox(width: 2),
            Text(
              '${agent['rating']}',
              style: GoogleFonts.dmSans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
