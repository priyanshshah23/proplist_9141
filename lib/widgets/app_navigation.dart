import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './custom_icon_widget.dart';

class _TabSpec {
  final String label;
  final String icon;
  final String selectedIcon;
  final int? branchIndex;

  const _TabSpec({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.branchIndex,
  });
}

class AppNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const AppNavigation({required this.navigationShell, super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedVisualIndex = 0;

  static const List<_TabSpec> _tabs = [
    _TabSpec(
      label: 'Home',
      icon: 'home_outlined',
      selectedIcon: 'home',
      branchIndex: 0,
    ),
    _TabSpec(
      label: 'Listings',
      icon: 'apartment_outlined',
      selectedIcon: 'apartment',
      branchIndex: 1,
    ),
    _TabSpec(
      label: 'Search',
      icon: 'search',
      selectedIcon: 'search',
      branchIndex: 2,
    ),
    _TabSpec(
      label: 'Saved',
      icon: 'favorite_border',
      selectedIcon: 'favorite',
      branchIndex: null,
    ),
  ];

  @override
  void didUpdateWidget(covariant AppNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentBranch = widget.navigationShell.currentIndex;
    for (int i = 0; i < _tabs.length; i++) {
      if (_tabs[i].branchIndex == currentBranch) {
        if (_selectedVisualIndex != i) {
          setState(() => _selectedVisualIndex = i);
        }
        break;
      }
    }
  }

  void _onTap(int index) {
    final tab = _tabs[index];
    if (tab.branchIndex == null) return; // stub tab — silent ignore
    setState(() => _selectedVisualIndex = index);
    widget.navigationShell.goBranch(
      tab.branchIndex!,
      initialLocation: tab.branchIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(31),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_tabs.length, (index) {
          final tab = _tabs[index];
          final isSelected = _selectedVisualIndex == index;
          final isStub = tab.branchIndex == null;
          return Opacity(
            opacity: isStub ? 0.4 : 1.0,
            child: GestureDetector(
              onTap: () => _onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE91E8C)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: isSelected ? tab.selectedIcon : tab.icon,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF9CA3AF),
                      size: 22,
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      child: isSelected
                          ? Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                tab.label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
