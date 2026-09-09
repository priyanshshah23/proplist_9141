import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/custom_icon_widget.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({super.key});

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  // TODO: Replace with [Riverpod/Bloc] for production
  int _selectedMethod = 0;

  static const List<Map<String, dynamic>> _methods = [
    {
      'label': 'Credit / Debit Card',
      'icon': 'credit_card',
      'sub': 'Visa, Mastercard, Amex',
    },
    {
      'label': 'Bank Transfer',
      'icon': 'account_balance',
      'sub': 'Direct bank payment',
    },
    {
      'label': 'Digital Wallet',
      'icon': 'account_balance_wallet',
      'sub': 'PayPal, Apple Pay',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: List.generate(_methods.length, (index) {
          final method = _methods[index];
          final isSelected = _selectedMethod == index;
          final isLast = index == _methods.length - 1;
          return GestureDetector(
            onTap: () => setState(() => _selectedMethod = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: Color(0xFFF3F4F6)),
                      ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE91E8C).withAlpha(26)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: method['icon'] as String,
                        color: isSelected
                            ? const Color(0xFFE91E8C)
                            : const Color(0xFF9CA3AF),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method['label'] as String,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        Text(
                          method['sub'] as String,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFE91E8C)
                            : const Color(0xFFD1D5DB),
                        width: isSelected ? 5 : 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
