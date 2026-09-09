import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './custom_icon_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;
  final bool useGradient;
  final Color? backgroundColor;
  final VoidCallback? onBack;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBack = false,
    this.actions,
    this.useGradient = true,
    this.backgroundColor,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: useGradient
          ? const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE91E8C), Color(0xFFFF6B9D)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            )
          : BoxDecoration(color: backgroundColor ?? Colors.white),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              if (showBack)
                GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).pop(),
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: useGradient
                          ? Colors.white.withAlpha(51)
                          : const Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'arrow_back_ios_new',
                        color: useGradient
                            ? Colors.white
                            : const Color(0xFF1A1A2E),
                        size: 18,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: useGradient ? Colors.white : const Color(0xFF1A1A2E),
                  ),
                ),
              ),
              if (actions != null) ...actions!,
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
