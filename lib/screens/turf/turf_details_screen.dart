import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../models/turf_model.dart';

class TurfDetailsScreen extends StatefulWidget {
  final TurfModel turf;
  const TurfDetailsScreen({super.key, required this.turf});

  @override
  State<TurfDetailsScreen> createState() => _TurfDetailsScreenState();
}

class _TurfDetailsScreenState extends State<TurfDetailsScreen> {
  int selectedDateIndex = 0;
  List<String> selectedSlots = [];
  int selectedSportIndex = 0;
  bool isFavorite = false;
  late List<DateTime> availableDates;
  late List<String> sportOptions;

  @override
  void initState() {
    super.initState();
    availableDates = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
    sportOptions = [];
    for (final sport in widget.turf.sports) {
      if (sport == 'Football') {
        sportOptions.addAll(['Football 5v5', 'Football 7v7']);
      } else {
        sportOptions.add(sport);
      }
    }
    if (sportOptions.isEmpty) sportOptions.add('General');
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroImage(c),
                  _buildTurfInfo(c),
                  _buildAboutVenue(c),
                  _buildFeatureGrid(c),
                  _buildSportSelector(c),
                  _buildDateTimeSelector(c),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(c),
    );
  }

  Widget _buildHeroImage(AppColors c) {
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(color: c.surfaceVariant),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: Icon(Icons.sports_soccer, size: 64, color: c.primary.withValues(alpha: 0.4)),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.turf.name.toUpperCase(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.textHint, letterSpacing: 2),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 60,
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, c.background])),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleBtn(Icons.arrow_back, c, onTap: () => Navigator.pop(context)),
              _circleBtn(isFavorite ? Icons.favorite : Icons.favorite_border, c, iconColor: isFavorite ? c.error : null, onTap: () => setState(() => isFavorite = !isFavorite)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleBtn(IconData icon, AppColors c, {Color? iconColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: c.isDark ? c.overlay : c.surface, shape: BoxShape.circle, boxShadow: [BoxShadow(color: c.shadow, blurRadius: 8)]),
        child: Icon(icon, color: iconColor ?? c.textPrimary, size: 20),
      ),
    );
  }

  Widget _buildTurfInfo(AppColors c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.turf.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: c.textPrimary))),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: c.ratingStarColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.star, color: c.ratingStarColor, size: 16),
                  const SizedBox(width: 4),
                  Text(widget.turf.rating.toString(), style: TextStyle(color: c.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            Icon(Icons.location_on, color: c.textSecondary, size: 16),
            const SizedBox(width: 4),
            Expanded(child: Text(widget.turf.location, style: TextStyle(fontSize: 14, color: c.textSecondary))),
            Text(' • ', style: TextStyle(color: c.textHint)),
            GestureDetector(onTap: () {}, child: Text('Map', style: TextStyle(fontSize: 14, color: c.accent, fontWeight: FontWeight.w600))),
          ]),
        ],
      ),
    );
  }

  Widget _buildAboutVenue(AppColors c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('About Venue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: c.textPrimary)),
        const SizedBox(height: 10),
        Text(widget.turf.description, style: TextStyle(fontSize: 14, color: c.textSecondary, height: 1.6)),
      ]),
    );
  }

  Widget _buildFeatureGrid(AppColors c) {
    final features = [
      {'icon': Icons.grid_on, 'label': 'Dimensions', 'value': '90 x 50 ft', 'color': c.primary},
      {'icon': Icons.grass, 'label': 'Surface', 'value': 'Artificial Turf', 'color': c.accentWarm},
      {'icon': Icons.checkroom, 'label': 'Facility', 'value': widget.turf.amenities.isNotEmpty ? widget.turf.amenities.first : 'Basic', 'color': c.success},
      {'icon': Icons.local_parking, 'label': 'Parking', 'value': widget.turf.amenities.contains('Parking') ? 'Free Spot' : 'Limited', 'color': c.accent},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.2,
        children: features.map((f) => Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: c.cardBorder)),
          child: Row(children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: (f['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
              child: Icon(f['icon'] as IconData, color: f['color'] as Color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(f['label'] as String, style: TextStyle(fontSize: 11, color: c.textHint)),
              const SizedBox(height: 2),
              Text(f['value'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.textPrimary)),
            ])),
          ]),
        )).toList(),
      ),
    );
  }

  Widget _buildSportSelector(AppColors c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Select Sport', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: c.textPrimary)),
        const SizedBox(height: 14),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, itemCount: sportOptions.length,
            itemBuilder: (context, index) {
              final isSelected = selectedSportIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => setState(() => selectedSportIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: isSelected ? c.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? c.primary : c.cardBorder),
                    ),
                    alignment: Alignment.center,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      if (isSelected) ...[const Icon(Icons.check, color: Colors.white, size: 14), const SizedBox(width: 6)],
                      Text(sportOptions[index], style: TextStyle(color: isSelected ? Colors.white : c.textSecondary, fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildDateTimeSelector(AppColors c) {
    final timeSlots = ['05:00 PM', '06:00 PM', '07:00 PM', '08:00 PM', '09:00 PM', '10:00 PM'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Select Date & Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: c.textPrimary)),
        const SizedBox(height: 16),
        SizedBox(
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, itemCount: availableDates.length,
            itemBuilder: (context, index) {
              final date = availableDates[index];
              final isSelected = selectedDateIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => setState(() { selectedDateIndex = index; selectedSlots.clear(); }),
                  child: Container(
                    width: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? c.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: isSelected ? c.primary : c.cardBorder),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(DateFormat('E').format(date).toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : c.textSecondary)),
                      const SizedBox(height: 4),
                      Text(date.day.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : c.textPrimary)),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10, runSpacing: 10,
          children: timeSlots.map((slot) {
            final isSelected = selectedSlots.contains(slot);
            final isBooked = slot == '05:00 PM';
            return GestureDetector(
              onTap: isBooked ? null : () => setState(() { isSelected ? selectedSlots.remove(slot) : selectedSlots.add(slot); }),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isBooked ? c.divider : isSelected ? c.primary : c.cardBorder, width: isSelected ? 1.5 : 1),
                  color: isBooked ? c.surfaceVariant.withValues(alpha: 0.5) : null,
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isBooked ? c.textHint : isSelected ? c.primary : c.textSecondary,
                    decoration: isBooked ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  Widget _buildBottomBar(AppColors c) {
    final totalPrice = widget.turf.pricePerHour * (selectedSlots.isEmpty ? 1 : selectedSlots.length);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: c.bottomBarBg,
        border: Border(top: BorderSide(color: c.divider)),
        boxShadow: [BoxShadow(color: c.shadow, blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Row(children: [
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Total Price', style: TextStyle(fontSize: 12, color: c.textSecondary)),
            const SizedBox(height: 2),
            RichText(text: TextSpan(children: [
              TextSpan(text: '₹${totalPrice.toInt()}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: c.textPrimary)),
              TextSpan(text: ' / hour', style: TextStyle(fontSize: 13, color: c.textSecondary)),
            ])),
          ]),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: selectedSlots.isEmpty ? null : _bookSlots,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: selectedSlots.isEmpty ? [c.surfaceVariant, c.surfaceVariant] : [c.primary, c.primaryDark]),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: selectedSlots.isNotEmpty ? [BoxShadow(color: c.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))] : null,
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(selectedSlots.isEmpty ? 'Select a Slot' : 'Book Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: selectedSlots.isEmpty ? c.textHint : Colors.white)),
                  if (selectedSlots.isNotEmpty) ...[const SizedBox(width: 8), const Icon(Icons.arrow_forward, color: Colors.white, size: 18)],
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _bookSlots() {
    final c = AppColors.of(context);
    final date = availableDates[selectedDateIndex];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Booking Confirmation', style: TextStyle(color: c.textPrimary)),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.turf.name, style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _confirmRow(Icons.calendar_today, DateFormat('dd MMM yyyy').format(date), c),
          const SizedBox(height: 8),
          _confirmRow(Icons.access_time, selectedSlots.join(', '), c),
          const SizedBox(height: 8),
          _confirmRow(Icons.payments, '₹${(widget.turf.pricePerHour * selectedSlots.length).toInt()}', c, valueColor: c.primary),
          const SizedBox(height: 16),
          Text('Booking confirmation will be sent to your phone', style: TextStyle(color: c.textHint, fontSize: 12)),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: TextStyle(color: c.textSecondary))),
          ElevatedButton(
            onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Booking confirmed!'), backgroundColor: c.primary)); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(backgroundColor: c.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _confirmRow(IconData icon, String text, AppColors c, {Color? valueColor}) {
    return Row(children: [
      Icon(icon, size: 16, color: c.accent),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: TextStyle(color: valueColor ?? c.textSecondary, fontSize: 14, fontWeight: valueColor != null ? FontWeight.bold : FontWeight.normal))),
    ]);
  }
}