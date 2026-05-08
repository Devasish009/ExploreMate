import 'package:flutter/material.dart';

class TripSchedulerScreen extends StatelessWidget {
  const TripSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> routes = [
      {
        'id': 1,
        'name': 'Triund Trek',
        'difficulty': 'Easy',
        'duration': '4-5 hours',
        'distance': '9 km',
        'altitude': '2,828m',
        'bestTime': 'Mar - Jun',
        'image': 'https://images.unsplash.com/photo-1635745488837-ffa006eaf9cf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
        'groupSize': '10-15 people'
      },
      {
        'id': 2,
        'name': 'Valley Trail',
        'difficulty': 'Moderate',
        'duration': '6-7 hours',
        'distance': '12 km',
        'altitude': '3,200m',
        'bestTime': 'Apr - Oct',
        'image': 'https://images.unsplash.com/photo-1640302616860-0645920b91b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
        'groupSize': '8-12 people'
      },
      {
        'id': 3,
        'name': 'Mountain Railway',
        'difficulty': 'Easy',
        'duration': '3 hours',
        'distance': '15 km',
        'altitude': '2,500m',
        'bestTime': 'Year Round',
        'image': 'https://images.unsplash.com/photo-1648610635770-5b426c424914?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
        'groupSize': '20+ people'
      },
      {
        'id': 4,
        'name': 'Peak Summit',
        'difficulty': 'Hard',
        'duration': '8-10 hours',
        'distance': '18 km',
        'altitude': '4,100m',
        'bestTime': 'May - Sep',
        'image': 'https://images.unsplash.com/photo-1599151459891-aa0e53bc2aaf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
        'groupSize': '6-8 people'
      }
    ];

    Color getDifficultyColor(String difficulty) {
      switch (difficulty) {
        case 'Easy':
          return Colors.green.shade700;
        case 'Moderate':
          return Colors.orange.shade700;
        case 'Hard':
          return Colors.red.shade700;
        default:
          return Colors.grey.shade700;
      }
    }

    Color getDifficultyBg(String difficulty) {
      switch (difficulty) {
        case 'Easy':
          return Colors.green.shade50;
        case 'Moderate':
          return Colors.orange.shade50;
        case 'Hard':
          return Colors.red.shade50;
        default:
          return Colors.grey.shade50;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trek Routes',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Discover scenic trails and adventures',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: routes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final route = routes[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 180,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        route['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey.shade300),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: getDifficultyBg(route['difficulty'] as String),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            route['difficulty'] as String,
                            style: TextStyle(
                              color: getDifficultyColor(route['difficulty'] as String),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route['name'] as String,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow(Icons.schedule, 'Duration', route['duration'] as String),
                          ),
                          Expanded(
                            child: _buildInfoRow(Icons.map, 'Distance', route['distance'] as String),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow(Icons.terrain, 'Altitude', route['altitude'] as String),
                          ),
                          Expanded(
                            child: _buildInfoRow(Icons.group, 'Group Size', route['groupSize'] as String),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Best Time',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                route['bestTime'] as String,
                                style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.blue.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(color: Colors.black87, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
