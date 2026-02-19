import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class OwnTurfScreen extends StatefulWidget {
  const OwnTurfScreen({super.key});

  @override
  State<OwnTurfScreen> createState() => _OwnTurfScreenState();
}

class _OwnTurfScreenState extends State<OwnTurfScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        elevation: 0,
        title: Text('Partner With Us', style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: c.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildHero(c),
            const SizedBox(height: 32),
            _buildBenefits(c),
            const SizedBox(height: 32),
            _buildForm(c),
            const SizedBox(height: 32),
            _buildSuccessStories(c),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(AppColors c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
            child: Icon(Icons.handshake, size: 32, color: c.primary),
          ),
          const SizedBox(height: 16),
          Text('List Your Turf', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: c.textPrimary)),
          const SizedBox(height: 8),
          Text(
            'Join our growing network of turf owners and reach thousands of sports enthusiasts.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: c.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefits(AppColors c) {
    final benefits = [
      {'icon': Icons.trending_up, 'title': 'Boost Revenue', 'desc': 'Increase bookings by up to 3x', 'color': c.primary},
      {'icon': Icons.public, 'title': 'Wider Reach', 'desc': 'Access 10K+ active players', 'color': c.accent},
      {'icon': Icons.dashboard, 'title': 'Easy Management', 'desc': 'Dashboard to manage slots', 'color': c.accentWarm},
      {'icon': Icons.support_agent, 'title': '24/7 Support', 'desc': 'Dedicated partner support', 'color': c.warning},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Why Partner With Us?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textPrimary)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4,
          children: benefits.map((b) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.cardBorder)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: (b['color'] as Color).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                child: Icon(b['icon'] as IconData, color: b['color'] as Color, size: 20),
              ),
              const Spacer(),
              Text(b['title'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
              const SizedBox(height: 2),
              Text(b['desc'] as String, style: TextStyle(fontSize: 11, color: c.textSecondary)),
            ]),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildForm(AppColors c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Get Started', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textPrimary)),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(children: [
            _field('Turf Name', _nameController, Icons.business, c),
            const SizedBox(height: 12),
            _field('Phone Number', _phoneController, Icons.phone, c, keyboard: TextInputType.phone),
            const SizedBox(height: 12),
            _field('Location', _locationController, Icons.location_on, c),
            const SizedBox(height: 12),
            _field('Description', _descriptionController, Icons.description, c, maxLines: 3),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: c.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                child: const Text('Submit Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _field(String label, TextEditingController ctrl, IconData icon, AppColors c, {TextInputType? keyboard, int maxLines = 1}) {
    return TextFormField(
      controller: ctrl, keyboardType: keyboard, maxLines: maxLines,
      style: TextStyle(color: c.textPrimary),
      validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label, labelStyle: TextStyle(color: c.textSecondary),
        prefixIcon: maxLines == 1 ? Icon(icon, color: c.textSecondary) : null,
        filled: true, fillColor: c.inputFill,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.cardBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c.primary, width: 1.5)),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final c = AppColors.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Partnership request submitted!'), backgroundColor: c.primary),
      );
      _nameController.clear(); _phoneController.clear(); _locationController.clear(); _descriptionController.clear();
    }
  }

  Widget _buildSuccessStories(AppColors c) {
    final stories = [
      {'name': 'Raj Sports Arena', 'owner': 'Rajesh Kumar', 'quote': 'Our bookings increased by 200% in 3 months!', 'rating': 4.9},
      {'name': 'Victory Ground', 'owner': 'Suresh Patel', 'quote': 'Excellent platform with great support team.', 'rating': 4.8},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Success Stories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textPrimary)),
        const SizedBox(height: 16),
        ...stories.map((s) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.cardBorder)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Icon(Icons.person, color: c.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s['name'] as String, style: TextStyle(fontWeight: FontWeight.w600, color: c.textPrimary)),
                Text(s['owner'] as String, style: TextStyle(fontSize: 12, color: c.textSecondary)),
              ]),
              const Spacer(),
              Row(children: [
                Icon(Icons.star, color: c.ratingStarColor, size: 14),
                const SizedBox(width: 3),
                Text(s['rating'].toString(), style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
              ]),
            ]),
            const SizedBox(height: 12),
            Text('"${s['quote']}"', style: TextStyle(color: c.textSecondary, fontStyle: FontStyle.italic, height: 1.4)),
          ]),
        )),
      ],
    );
  }
}