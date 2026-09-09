import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import './widgets/auth_form_widget.dart';
import './widgets/auth_header_widget.dart';
import './widgets/auth_toggle_widget.dart';

class SignUpLoginScreen extends StatefulWidget {
  const SignUpLoginScreen({super.key});

  @override
  State<SignUpLoginScreen> createState() => _SignUpLoginScreenState();
}

class _SignUpLoginScreenState extends State<SignUpLoginScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with [Riverpod/Bloc] for production
  bool _isLogin = true;
  late AnimationController _bgController;
  late Animation<double> _bgAnimation;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bgAnimation = CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() => _isLogin = !_isLogin);
    if (_isLogin) {
      _bgController.reverse();
    } else {
      _bgController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isTablet
            ? Center(child: SizedBox(width: 480, child: _buildContent()))
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          AuthHeaderWidget(isLogin: _isLogin),
          const SizedBox(height: 32),
          AuthToggleWidget(isLogin: _isLogin, onToggle: _toggleMode),
          const SizedBox(height: 32),
          AuthFormWidget(
            isLogin: _isLogin,
            onSuccess: () => context.go(AppRoutes.homeScreen),
          ),
          const SizedBox(height: 24),
          _buildDivider(),
          const SizedBox(height: 20),
          _buildGoogleButton(),
          const SizedBox(height: 24),
          _buildBottomLink(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => context.go(AppRoutes.homeScreen),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFFE5E7EB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Icon(
                Icons.g_mobiledata_rounded,
                size: 22,
                color: Color(0xFFE91E8C),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Continue with Google',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A2E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomLink() {
    return Center(
      child: GestureDetector(
        onTap: _toggleMode,
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
            children: [
              TextSpan(
                text: _isLogin
                    ? "Don't have an account? "
                    : "Already have an account? ",
              ),
              TextSpan(
                text: _isLogin ? 'Sign Up' : 'Log In',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE91E8C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
