import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../models/turf_model.dart';
import 'turf_details_screen.dart';

class TurfListScreen extends StatefulWidget {
  const TurfListScreen({super.key});

  @override
  State<TurfListScreen> createState() => _TurfListScreenState();
}

class _TurfListScreenState extends State<TurfListScreen> {
  String selectedSport = 'All Sports';
  String selectedArea = 'All Areas';
  RangeValues priceRange = const RangeValues(0, 2000);
  String sortBy = 'Highest Rated';
  
  final List<String> sports = [
    'All Sports',
    'Cricket',
    'Football',
    'Badminton',
    'Box Cricket',
  ];
  
  final List<String> areas = [
    'All Areas',
    'Shastri Circle',
    'Rajendra Marg',
    'Pur Road',
    'Sanjay Colony',
    'Azad Nagar',
  ];
  
  final List<String> sortOptions = [
    'Highest Rated',
    'Lowest Price',
    'Highest Price',
    'Most Popular',
  ];

  List<TurfModel> get filteredTurfs {
    List<TurfModel> turfs = TurfModel.getDummyTurfs();
    
    // Filter by sport
    if (selectedSport != 'All Sports') {
      turfs = turfs.where((turf) => turf.sports.contains(selectedSport)).toList();
    }
    
    // Filter by price range
    turfs = turfs.where((turf) => 
      turf.pricePerHour >= priceRange.start && 
      turf.pricePerHour <= priceRange.end
    ).toList();
    
    // Sort
    switch (sortBy) {
      case 'Lowest Price':
        turfs.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour));
        break;
      case 'Highest Price':
        turfs.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour));
        break;
      case 'Most Popular':
        turfs.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      default: // Highest Rated
        turfs.sort((a, b) => b.rating.compareTo(a.rating));
    }
    
    return turfs;
  }

  @override
  Widget build(BuildContext context) {
    final turfs = filteredTurfs;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Find Your Perfect Turf'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Browse through our collection of premium sports facilities in Bhilwara',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${turfs.length} turfs found',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.sort, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            sortBy,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Turf List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: turfs.length,
              itemBuilder: (context, index) {
                return _buildTurfCard(turfs[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTurfCard(TurfModel turf) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TurfDetailsScreen(turf: turf),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Turf Image with badges
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryGreen.withOpacity(0.3),
                          AppTheme.darkGreen.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: const Icon(
                      Icons.sports_soccer,
                      size: 80,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  
                  // Badges
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Row(
                      children: [
                        if (turf.isPopular)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'POPULAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (turf.discount.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentYellow,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              turf.discount,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Sports tags
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Row(
                      children: turf.sports.take(2).map((sport) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            sport,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              
              // Turf Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            turf.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppTheme.accentYellow,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${turf.rating} (${turf.reviewCount})',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppTheme.primaryGreen,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            turf.location,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Text(
                      turf.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${turf.pricePerHour}/hour',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TurfDetailsScreen(turf: turf),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          ),
                          child: const Text('View Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Sport Filter
                  const Text(
                    'Sport',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedSport,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    dropdownColor: AppTheme.cardColor,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    items: sports.map((sport) {
                      return DropdownMenuItem(
                        value: sport,
                        child: Text(sport),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        selectedSport = value!;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Price Range
                  const Text(
                    'Price Range (₹/hour)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 2000,
                    divisions: 20,
                    activeColor: AppTheme.primaryGreen,
                    labels: RangeLabels(
                      '₹${priceRange.start.round()}',
                      '₹${priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setModalState(() {
                        priceRange = values;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Sort By
                  const Text(
                    'Sort By',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: sortBy,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    dropdownColor: AppTheme.cardColor,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    items: sortOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        sortBy = value!;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}