import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_colors.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }
    setState(() => _otpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('OTP sent successfully!'), backgroundColor: AppColors.of(context).primary),
    );
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userPhone', _phoneController.text);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.sports_soccer, size: 44, color: c.primary),
                ),
              ),
              const SizedBox(height: 32),
              Center(child: Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: c.textPrimary))),
              const SizedBox(height: 8),
              Center(child: Text('Login to book your favourite turf', style: TextStyle(fontSize: 15, color: c.textSecondary))),
              const SizedBox(height: 40),

              Text('Phone Number', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: c.textPrimary, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Enter your phone number', hintStyle: TextStyle(color: c.textHint),
                  prefixIcon: Icon(Icons.phone_outlined, color: c.textSecondary),
                  filled: true, fillColor: c.inputFill,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.primary, width: 1.5)),
                ),
              ),
              const SizedBox(height: 16),

              if (_otpSent) ...[
                Text('OTP', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
                const SizedBox(height: 8),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number, maxLength: 6,
                  style: TextStyle(color: c.textPrimary, fontSize: 16, letterSpacing: 8), textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '------', hintStyle: TextStyle(color: c.textHint, letterSpacing: 8), counterText: '',
                    filled: true, fillColor: c.inputFill,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.primary, width: 1.5)),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _otpSent ? _verifyOtp : _sendOtp,
                  style: ElevatedButton.styleFrom(backgroundColor: c.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                  child: Text(_otpSent ? 'Verify OTP' : 'Send OTP', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "Don't have an account? ", style: TextStyle(color: c.textSecondary, fontSize: 14)),
                      TextSpan(text: 'Sign Up', style: TextStyle(color: c.primary, fontSize: 14, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              _buildFeatureRow(Icons.flash_on, 'Instant Booking', 'Book your slot in seconds', c),
              const SizedBox(height: 16),
              _buildFeatureRow(Icons.verified_user, 'Verified Turfs', 'All turfs quality-checked', c),
              const SizedBox(height: 16),
              _buildFeatureRow(Icons.access_time, '24/7 Available', 'Book anytime, play anytime', c),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle, AppColors c) {
    return Row(children: [
      Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: c.primary, size: 22),
      ),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: c.textPrimary)),
        Text(subtitle, style: TextStyle(fontSize: 13, color: c.textSecondary)),
      ]),
    ]);
  }
}