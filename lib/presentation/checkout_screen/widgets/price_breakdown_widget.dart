import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceBreakdownWidget extends StatelessWidget {
  final int price;
  final bool isRent;

  const PriceBreakdownWidget({
    super.key,
    required this.price,
    required this.isRent,
  });

  String _fmt(int v) =>
      '\$${v.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';

  @override
  Widget build(BuildContext context) {
    final deposit = isRent ? (price * 2) : 0;
    final serviceFee = (price * 0.05).round();
    final total = price + deposit + serviceFee;

    final rows = [
      if (isRent) ...[
        {'label': 'Monthly Rent', 'value': _fmt(price), 'bold': false},
        {
          'label': 'Security Deposit (2 mo)',
          'value': _fmt(deposit),
          'bold': false,
        },
      ] else ...[
        {'label': 'Property Price', 'value': _fmt(price), 'bold': false},
      ],
      {'label': 'Service Fee (5%)', 'value': _fmt(serviceFee), 'bold': false},
      {'label': 'Total Due Today', 'value': _fmt(total), 'bold': true},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final i = entry.key;
          final row = entry.value;
          final isBold = row['bold'] as bool;
          final isLast = i == rows.length - 1;
          return Column(
            children: [
              if (isLast)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Divider(color: Color(0xFFE5E7EB)),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    row['label'] as String,
                    style: GoogleFonts.dmSans(
                      fontSize: isBold ? 14 : 13,
                      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
                      color: isBold
                          ? const Color(0xFF1A1A2E)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                  Text(
                    row['value'] as String,
                    style: GoogleFonts.dmSans(
                      fontSize: isBold ? 16 : 13,
                      fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
                      color: isBold
                          ? const Color(0xFFE91E8C)
                          : const Color(0xFF1A1A2E),
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              if (!isLast) const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}
