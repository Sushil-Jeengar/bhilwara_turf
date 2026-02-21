import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/turf_model.dart';
import '../turf/turf_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedSport = 'All Sports';
  final TextEditingController _searchController = TextEditingController();

  final List<String> sports = ['All Sports', 'Football', 'Cricket', 'Badminton', 'Box Cricket'];

  final Map<String, IconData> sportIcons = {
    'All Sports': Icons.sports,
    'Football': Icons.sports_soccer,
    'Cricket': Icons.sports_cricket,
    'Badminton': Icons.sports_tennis,
    'Box Cricket': Icons.sports_cricket,
  };

  List<TurfModel> get filteredTurfs {
    List<TurfModel> turfs = TurfModel.getDummyTurfs();
    if (selectedSport != 'All Sports') {
      turfs = turfs.where((turf) => turf.sports.contains(selectedSport)).toList();
    }
    return turfs;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              const SizedBox(height: 16),
              _buildSearchBar(c),
              const SizedBox(height: 20),
              _buildSportChips(c),
              const SizedBox(height: 24),
              _buildPopularNearbyHeader(c),
              const SizedBox(height: 16),
              _buildTurfCards(c),
              const SizedBox(height: 20),
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
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: c.primary, size: 16),
                    const SizedBox(width: 4),
                    Text('Location', style: TextStyle(color: c.textHint, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Bhilwara', style: TextStyle(color: c.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, color: c.textSecondary, size: 20),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: c.primary,
              boxShadow: [BoxShadow(color: c.shadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: c.inputFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.cardBorder),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.search, color: c.textHint, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: c.textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search for location or venue',
                  hintStyle: TextStyle(color: c.textHint, fontSize: 14),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(color: c.surfaceVariant, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.tune, color: c.primary, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSportChips(AppColors c) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: sports.length,
        itemBuilder: (context, index) {
          final sport = sports[index];
          final isSelected = selectedSport == sport;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => selectedSport = sport),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? c.selectedChipBg : c.unselectedChipBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? c.primary : c.cardBorder, width: isSelected ? 1.5 : 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sportIcons.containsKey(sport)) ...[
                      Icon(sportIcons[sport], color: isSelected ? c.primary : c.textSecondary, size: 16),
                      const SizedBox(width: 6),
                    ],
                    Text(sport, style: TextStyle(color: isSelected ? c.primary : c.textSecondary, fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularNearbyHeader(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Popular Nearby', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textPrimary)),
          GestureDetector(
            onTap: () {},
            child: Text('See all', style: TextStyle(fontSize: 14, color: c.primary, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildTurfCards(AppColors c) {
    final turfs = filteredTurfs;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: turfs.length,
      itemBuilder: (context, index) => _buildTurfCard(turfs[index], c),
    );
  }

  Widget _buildTurfCard(TurfModel turf, AppColors c) {
    IconData sportIcon = Icons.sports_soccer;
    if (turf.sports.contains('Cricket')) sportIcon = Icons.sports_cricket;
    if (turf.sports.contains('Badminton')) sportIcon = Icons.sports_tennis;

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TurfDetailsScreen(turf: turf))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: c.cardBorder),
          boxShadow: [BoxShadow(color: c.shadow, blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: c.surfaceVariant,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Icon(sportIcon, size: 48, color: c.primary.withValues(alpha: 0.4)),
                    ),
                  ),
                  if (turf.distance.isNotEmpty)
                    Positioned(
                      top: 12, right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: c.overlay, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.navigation, color: c.accent, size: 12),
                            const SizedBox(width: 4),
                            Text(turf.distance, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  if (turf.availability.isNotEmpty)
                    Positioned(
                      bottom: 12, left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: turf.availability == 'HIGH DEMAND' ? c.badgeHighDemand : c.badgeAvailable,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(turf.availability, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ),
                    ),
                  if (turf.discount.isNotEmpty)
                    Positioned(
                      top: 12, left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: c.warning, borderRadius: BorderRadius.circular(6)),
                        child: Text(turf.discount, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(turf.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: c.textPrimary))),
                      const SizedBox(width: 8),
                      Icon(Icons.star, color: c.ratingStarColor, size: 16),
                      const SizedBox(width: 3),
                      Text(turf.rating.toString(), style: TextStyle(color: c.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(child: Text(turf.sportFormat.isNotEmpty ? turf.sportFormat : turf.sports.join(' • '), style: TextStyle(fontSize: 13, color: c.textSecondary))),
                      Text('(${turf.reviewCount})', style: TextStyle(fontSize: 13, color: c.textHint)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: '₹${turf.pricePerHour.toInt()}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textPrimary)),
                          TextSpan(text: ' / hour', style: TextStyle(fontSize: 14, color: c.textSecondary)),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TurfDetailsScreen(turf: turf))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: c.primary)),
                          child: Text('Book Slot', style: TextStyle(color: c.primary, fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}