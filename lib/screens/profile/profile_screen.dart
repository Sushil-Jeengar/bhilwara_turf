import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  bool isOwnerMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User';
      userPhone = prefs.getString('userPhone') ?? '+91 XXXXXXXXXX';
      userEmail = prefs.getString('userEmail') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(c),
              const SizedBox(height: 24),
              _buildAvatarSection(c),
              const SizedBox(height: 28),
              _buildOwnerModeToggle(c),
              const SizedBox(height: 32),
              _buildSectionTitle('ACCOUNT', c),
              const SizedBox(height: 12),
              _buildAccountSection(c),
              const SizedBox(height: 32),
              _buildSectionTitle('SUPPORT', c),
              const SizedBox(height: 12),
              _buildSupportSection(c),
              const SizedBox(height: 32),
              _buildLogoutButton(c),
              const SizedBox(height: 16),
              Center(child: Text('Version 1.0.0', style: TextStyle(color: c.textHint, fontSize: 13))),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppColors c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: c.textPrimary)),
          GestureDetector(onTap: _editProfile, child: Text('Edit', style: TextStyle(fontSize: 16, color: c.primary, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildAvatarSection(AppColors c) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c.surfaceVariant,
                  border: Border.all(color: c.primary.withValues(alpha: 0.3), width: 2),
                ),
                child: Icon(Icons.person, size: 50, color: c.textSecondary),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle, border: Border.all(color: c.background, width: 3)),
                  child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(userName.isNotEmpty ? userName : 'User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: c.textPrimary)),
          const SizedBox(height: 4),
          Text(userPhone, style: TextStyle(fontSize: 14, color: c.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildOwnerModeToggle(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.cardBorder)),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.sports_soccer, color: c.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Switch to Owner Mode', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: c.textPrimary)),
                  const SizedBox(height: 2),
                  Text('Manage your turfs & bookings', style: TextStyle(fontSize: 12, color: c.textSecondary)),
                ],
              ),
            ),
            Switch(
              value: isOwnerMode,
              onChanged: (value) {
                setState(() => isOwnerMode = value);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value ? 'Owner mode enabled' : 'Owner mode disabled'), backgroundColor: c.primary, duration: const Duration(seconds: 1)),
                );
              },
              activeThumbColor: Colors.white,
              activeTrackColor: c.primary,
              inactiveThumbColor: c.textSecondary,
              inactiveTrackColor: c.surfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.textHint, letterSpacing: 1.2)),
    );
  }

  Widget _buildAccountSection(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.cardBorder)),
        child: Column(children: [
          _buildMenuItem(icon: Icons.calendar_today_outlined, title: 'My Bookings', subtitle: 'Upcoming: Green Valley Turf, 7 PM', subtitleColor: c.primary, onTap: () {}, c: c),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1, color: c.divider)),
          _buildMenuItem(icon: Icons.credit_card_outlined, title: 'Payment Methods', subtitle: 'UPI / Cash on arrival', onTap: () {}, c: c),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1, color: c.divider)),
          _buildMenuItem(icon: Icons.settings_outlined, title: 'Settings', onTap: () {}, c: c),
        ]),
      ),
    );
  }

  Widget _buildSupportSection(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.cardBorder)),
        child: _buildMenuItem(icon: Icons.help_outline, title: 'Help & Support', onTap: () {}, c: c),
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, String? subtitle, Color? subtitleColor, required VoidCallback onTap, required AppColors c}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: c.textSecondary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: c.textPrimary)),
              if (subtitle != null) ...[const SizedBox(height: 3), Text(subtitle, style: TextStyle(fontSize: 12, color: subtitleColor ?? c.textSecondary))],
            ]),
          ),
          Icon(Icons.chevron_right, color: c.textHint, size: 22),
        ]),
      ),
    );
  }

  Widget _buildLogoutButton(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _logout,
        child: Container(
          width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: c.error.withValues(alpha: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: c.error, size: 20),
              const SizedBox(width: 10),
              Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: c.error)),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    final c = AppColors.of(context);
    showDialog(
      context: context,
      builder: (ctx) {
        final nameCtrl = TextEditingController(text: userName);
        final emailCtrl = TextEditingController(text: userEmail);
        return AlertDialog(
          backgroundColor: c.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Edit Profile', style: TextStyle(color: c.textPrimary)),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: c.textSecondary), filled: true, fillColor: c.inputFill, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)), style: TextStyle(color: c.textPrimary)),
            const SizedBox(height: 16),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: c.textSecondary), filled: true, fillColor: c.inputFill, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)), style: TextStyle(color: c.textPrimary)),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: TextStyle(color: c.textSecondary))),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('userName', nameCtrl.text);
                await prefs.setString('userEmail', emailCtrl.text);
                setState(() { userName = nameCtrl.text; userEmail = emailCtrl.text; });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Profile updated'), backgroundColor: c.primary));
              },
              style: ElevatedButton.styleFrom(backgroundColor: c.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    final c = AppColors.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Log Out', style: TextStyle(color: c.textPrimary)),
        content: Text('Are you sure you want to log out?', style: TextStyle(color: c.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: TextStyle(color: c.textSecondary))),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: c.error, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}