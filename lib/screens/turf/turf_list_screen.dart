import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/turf_model.dart';
import 'turf_details_screen.dart';

class TurfListScreen extends StatefulWidget {
  const TurfListScreen({super.key});

  @override
  State<TurfListScreen> createState() => _TurfListScreenState();
}

class _TurfListScreenState extends State<TurfListScreen> {
  String selectedSport = 'All';
  String sortBy = 'Highest Rated';
  RangeValues priceRange = const RangeValues(0, 2000);
  final List<String> sports = ['All', 'Cricket', 'Football', 'Badminton', 'Box Cricket'];

  List<TurfModel> get filteredTurfs {
    var turfs = TurfModel.getDummyTurfs();
    if (selectedSport != 'All') {
      turfs = turfs.where((t) => t.sports.contains(selectedSport)).toList();
    }
    turfs = turfs.where((t) => t.pricePerHour >= priceRange.start && t.pricePerHour <= priceRange.end).toList();
    switch (sortBy) {
      case 'Lowest Price': turfs.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour)); break;
      case 'Highest Price': turfs.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour)); break;
      case 'Most Popular': turfs.sort((a, b) => b.reviewCount.compareTo(a.reviewCount)); break;
      default: turfs.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return turfs;
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final turfs = filteredTurfs;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        elevation: 0,
        title: Text('All Turfs', style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: c.textPrimary),
        actions: [
          IconButton(icon: Icon(Icons.tune, color: c.textSecondary), onPressed: () => _showFilterSheet(c)),
        ],
      ),
      body: Column(
        children: [
          // Sport chips
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sports.length,
              itemBuilder: (context, index) {
                final sport = sports[index];
                final isSelected = selectedSport == sport;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(sport),
                    selected: isSelected,
                    onSelected: (_) => setState(() => selectedSport = sport),
                    backgroundColor: c.surface,
                    selectedColor: c.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : c.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(color: isSelected ? c.primary : c.cardBorder),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Results count + sort
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${turfs.length} turfs found', style: TextStyle(color: c.textSecondary, fontSize: 14)),
                DropdownButton<String>(
                  value: sortBy,
                  underline: const SizedBox(),
                  icon: Icon(Icons.sort, color: c.textSecondary, size: 18),
                  dropdownColor: c.surface,
                  style: TextStyle(color: c.textSecondary, fontSize: 13),
                  items: ['Highest Rated', 'Lowest Price', 'Highest Price', 'Most Popular']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) { if (v != null) setState(() => sortBy = v); },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Turf list
          Expanded(
            child: turfs.isEmpty
                ? Center(child: Text('No turfs found', style: TextStyle(color: c.textSecondary, fontSize: 16)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: turfs.length,
                    itemBuilder: (context, index) => _buildTurfCard(turfs[index], c),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTurfCard(TurfModel turf, AppColors c) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TurfDetailsScreen(turf: turf))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.cardBorder),
          boxShadow: [BoxShadow(color: c.shadow, blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            // Image area
            Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                color: c.surfaceVariant,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              ),
              child: Center(
                child: Icon(
                  turf.sports.contains('Cricket') ? Icons.sports_cricket :
                  turf.sports.contains('Badminton') ? Icons.sports_tennis : Icons.sports_soccer,
                  size: 40, color: c.primary.withValues(alpha: 0.4),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(turf.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(turf.location, style: TextStyle(fontSize: 12, color: c.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Row(children: [
                      Icon(Icons.star, color: c.ratingStarColor, size: 14),
                      const SizedBox(width: 3),
                      Text('${turf.rating} (${turf.reviewCount})', style: TextStyle(color: c.textSecondary, fontSize: 12)),
                      const Spacer(),
                      Text('₹${turf.pricePerHour.toInt()}/hr', style: TextStyle(color: c.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                    ]),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      children: turf.sports.take(3).map((s) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(4)),
                        child: Text(s, style: TextStyle(fontSize: 10, color: c.primary, fontWeight: FontWeight.w500)),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(AppColors c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: c.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: c.divider, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textPrimary)),
              const SizedBox(height: 20),
              Text('Price Range', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
              const SizedBox(height: 8),
              RangeSlider(
                values: priceRange,
                min: 0, max: 2000, divisions: 20,
                labels: RangeLabels('₹${priceRange.start.toInt()}', '₹${priceRange.end.toInt()}'),
                activeColor: c.primary,
                inactiveColor: c.surfaceVariant,
                onChanged: (v) { setSheetState(() => priceRange = v); },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('₹${priceRange.start.toInt()}', style: TextStyle(color: c.textSecondary)),
                Text('₹${priceRange.end.toInt()}', style: TextStyle(color: c.textSecondary)),
              ]),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 48,
                child: ElevatedButton(
                  onPressed: () { setState(() {}); Navigator.pop(ctx); },
                  style: ElevatedButton.styleFrom(backgroundColor: c.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Apply Filters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}