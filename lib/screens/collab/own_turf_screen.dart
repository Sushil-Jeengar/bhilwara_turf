import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Own a Turf'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(),
            
            const SizedBox(height: 32),
            
            // Benefits Section
            _buildBenefitsSection(),
            
            const SizedBox(height: 32),
            
            // Partnership Form
            _buildPartnershipForm(),
            
            const SizedBox(height: 32),
            
            // Success Stories
            _buildSuccessStories(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Own a Turf in',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Bhilwara?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'List your turf on our platform and reach thousands of players. Increase your bookings and grow your business.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.business,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Scroll to form
                    Scrollable.ensureVisible(
                      _formKey.currentContext!,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Partner With Us',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showLearnMoreDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Learn More',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why Partner With BhilwaraTurf?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildBenefitCard(
          icon: Icons.trending_up,
          title: 'Increase Revenue',
          description: 'Get more bookings and maximize your turf utilization with our large user base.',
          color: AppTheme.primaryGreen,
        ),
        
        const SizedBox(height: 16),
        
        _buildBenefitCard(
          icon: Icons.people,
          title: 'Reach More Players',
          description: 'Connect with thousands of sports enthusiasts in Bhilwara looking for quality turfs.',
          color: AppTheme.accentOrange,
        ),
        
        const SizedBox(height: 16),
        
        _buildBenefitCard(
          icon: Icons.phone_android,
          title: 'Easy Management',
          description: 'Manage bookings, payments, and customer communication through our platform.',
          color: AppTheme.accentYellow,
        ),
        
        const SizedBox(height: 16),
        
        _buildBenefitCard(
          icon: Icons.support_agent,
          title: '24/7 Support',
          description: 'Get dedicated support from our team to help you grow your business.',
          color: AppTheme.darkGreen,
        ),
      ],
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnershipForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ready to Partner?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill out the form below and our team will get in touch with you within 24 hours.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Owner Name
            const Text(
              'Owner Name *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person, color: AppTheme.primaryGreen),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Phone Number
            const Text(
              'Phone Number *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.phone, color: AppTheme.primaryGreen),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length != 10) {
                  return 'Please enter valid 10-digit phone number';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Turf Location
            const Text(
              'Turf Location *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                hintText: 'Enter your turf location',
                prefixIcon: Icon(Icons.location_on, color: AppTheme.primaryGreen),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter turf location';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Description
            const Text(
              'Tell us about your turf',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Describe your turf facilities, sports available, etc.',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Icon(Icons.description, color: AppTheme.primaryGreen),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Submit Partnership Request',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'By submitting this form, you agree to our terms and conditions. Our team will contact you within 24 hours to discuss the partnership details.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessStories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Success Stories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildSuccessStoryCard(
          name: 'Rajesh Kumar',
          turfName: 'Green Arena Sports Complex',
          story: 'Increased my bookings by 300% within 3 months of partnering with BhilwaraTurf. The platform is amazing!',
          rating: 5,
        ),
        
        const SizedBox(height: 16),
        
        _buildSuccessStoryCard(
          name: 'Priya Sharma',
          turfName: 'Victory Turf Ground',
          story: 'Best decision for my business. The support team is very helpful and the booking management is seamless.',
          rating: 5,
        ),
        
        const SizedBox(height: 16),
        
        _buildSuccessStoryCard(
          name: 'Amit Jain',
          turfName: 'Champion\'s Cricket Academy',
          story: 'Great platform with excellent reach. My turf is now booked almost every day. Highly recommended!',
          rating: 5,
        ),
      ],
    );
  }

  Widget _buildSuccessStoryCard({
    required String name,
    required String turfName,
    required String story,
    required int rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      turfName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(rating, (index) {
                  return const Icon(
                    Icons.star,
                    color: AppTheme.accentYellow,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Text(
            '"$story"',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppTheme.cardColor,
            title: const Text(
              'Request Submitted!',
              style: TextStyle(color: AppTheme.textPrimary),
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryGreen,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Thank you for your interest in partnering with us! Our team will contact you within 24 hours to discuss the next steps.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Clear form
                  _nameController.clear();
                  _phoneController.clear();
                  _locationController.clear();
                  _descriptionController.clear();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showLearnMoreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardColor,
          title: const Text(
            'Partnership Benefits',
            style: TextStyle(color: AppTheme.textPrimary),
          ),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What we offer:',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '• Free listing on our platform\n'
                  '• Professional photography of your turf\n'
                  '• Online booking management\n'
                  '• Payment processing\n'
                  '• Customer support\n'
                  '• Marketing and promotion\n'
                  '• Analytics and insights\n'
                  '• Mobile app presence',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Requirements:',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '• Valid turf ownership documents\n'
                  '• Basic facilities (changing rooms, parking)\n'
                  '• Commitment to quality service\n'
                  '• Flexible booking policies',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Scroll to form
                Scrollable.ensureVisible(
                  _formKey.currentContext!,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        );
      },
    );
  }
}