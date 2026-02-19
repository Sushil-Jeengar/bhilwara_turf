import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_nameController.text.isEmpty || _phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    setState(() => _otpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('OTP sent successfully!'), backgroundColor: AppColors.of(context).primary),
    );
  }

  Future<void> _verifyOtpAndSignup() async {
    if (_otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userPhone', _phoneController.text);
    await prefs.setString('userEmail', _emailController.text);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: c.textPrimary), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: c.textPrimary)),
              const SizedBox(height: 8),
              Text('Sign up to start booking turfs', style: TextStyle(fontSize: 15, color: c.textSecondary)),
              const SizedBox(height: 32),

              _buildField('Full Name', _nameController, Icons.person_outline, 'Enter your name', c),
              const SizedBox(height: 16),
              _buildField('Phone Number', _phoneController, Icons.phone_outlined, 'Enter phone number', c, keyboard: TextInputType.phone),
              const SizedBox(height: 16),
              _buildField('Email (Optional)', _emailController, Icons.email_outlined, 'Enter your email', c, keyboard: TextInputType.emailAddress),

              if (_otpSent) ...[
                const SizedBox(height: 16),
                Text('OTP', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
                const SizedBox(height: 8),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TextStyle(color: c.textPrimary, fontSize: 16, letterSpacing: 8),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '------', hintStyle: TextStyle(color: c.textHint, letterSpacing: 8), counterText: '',
                    filled: true, fillColor: c.inputFill,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.primary, width: 1.5)),
                  ),
                ),
              ],

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _otpSent ? _verifyOtpAndSignup : _sendOtp,
                  style: ElevatedButton.styleFrom(backgroundColor: c.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                  child: Text(_otpSent ? 'Verify & Sign Up' : 'Send OTP', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Already have an account? ', style: TextStyle(color: c.textSecondary, fontSize: 14)),
                      TextSpan(text: 'Login', style: TextStyle(color: c.primary, fontSize: 14, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, IconData icon, String hint, AppColors c, {TextInputType? keyboard}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
      const SizedBox(height: 8),
      TextField(
        controller: ctrl, keyboardType: keyboard,
        style: TextStyle(color: c.textPrimary, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint, hintStyle: TextStyle(color: c.textHint),
          prefixIcon: Icon(icon, color: c.textSecondary),
          filled: true, fillColor: c.inputFill,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.primary, width: 1.5)),
        ),
      ),
    ]);
  }
}