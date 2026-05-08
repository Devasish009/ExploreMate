import 'package:flutter/material.dart';
import '../app_colors.dart';

class TripSchedulerScreen extends StatefulWidget {
  const TripSchedulerScreen({super.key});

  @override
  State<TripSchedulerScreen> createState() => _TripSchedulerScreenState();
}

class _TripSchedulerScreenState extends State<TripSchedulerScreen> {
  int _selectedDay = 0;

  final List<List<Map<String, dynamic>>> _schedule = [
    [
      {'time': '9:00 AM', 'place': 'RK Beach', 'desc': 'Scenic morning walk', 'duration': '1.5 hrs', 'icon': Icons.beach_access_rounded},
      {'time': '11:30 AM', 'place': 'Submarine Museum', 'desc': 'Hidden gem · Must visit', 'duration': '2 hrs', 'icon': Icons.water_rounded},
      {'time': '2:00 PM', 'place': 'Kailasagiri', 'desc': 'Hill viewpoint & ropeway', 'duration': '3 hrs', 'icon': Icons.landscape_rounded},
      {'time': '7:00 PM', 'place': 'Jagadamba', 'desc': 'Street food evening', 'duration': 'Evening', 'icon': Icons.restaurant_rounded},
    ],
    [
      {'time': '8:00 AM', 'place': 'Borra Caves', 'desc': 'Limestone cave formations', 'duration': '3 hrs', 'icon': Icons.terrain_rounded},
      {'time': '1:00 PM', 'place': 'Araku Valley', 'desc': 'Coffee plantations', 'duration': '4 hrs', 'icon': Icons.forest_rounded},
      {'time': '6:00 PM', 'place': 'Tribal Museum', 'desc': 'Local art & culture', 'duration': '1.5 hrs', 'icon': Icons.museum_rounded},
    ],
    [
      {'time': '9:00 AM', 'place': 'Yarada Beach', 'desc': 'Secluded beach', 'duration': '2 hrs', 'icon': Icons.beach_access_rounded},
      {'time': '12:00 PM', 'place': 'Bheemunipatnam', 'desc': 'Dutch ruins & beach', 'duration': '3 hrs', 'icon': Icons.account_balance_rounded},
      {'time': '4:00 PM', 'place': 'Simhachalam', 'desc': 'Ancient hilltop temple', 'duration': '2 hrs', 'icon': Icons.temple_hindu_rounded},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Trip Scheduler'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded, color: Colors.white70, size: 18),
            label: const Text('Add', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Vizag · Apr 14–17',
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          _buildTripSummary(),
          Expanded(child: _buildTimeline()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
        label: const Text('AI Plan', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: List.generate(3, (i) {
          final isSelected = i == _selectedDay;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedDay = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.borderColor,
                      width: 0.5),
                ),
                child: Column(
                  children: [
                    Text('Day ${i + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : AppColors.primaryDark)),
                    Text(['Apr 14', 'Apr 15', 'Apr 16'][i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9,
                            color: isSelected ? Colors.white70 : AppColors.textMuted)),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTripSummary() {
    final stops = _schedule[_selectedDay].length;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.tileLight1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem(Icons.place_rounded, '$stops Stops'),
          _summaryItem(Icons.schedule_rounded, '~10 hrs'),
          _summaryItem(Icons.directions_car_rounded, '~120 km'),
        ],
      ),
    );
  }

  Widget _summaryItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 14),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.primaryDark, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTimeline() {
    final stops = _schedule[_selectedDay];
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 100),
      itemCount: stops.length,
      itemBuilder: (_, i) {
        final s = stops[i];
        final isLast = i == stops.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 28,
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    Container(
                      width: 12, height: 12,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(width: 1.5, color: AppColors.borderColor, margin: const EdgeInsets.symmetric(vertical: 4)),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderColor, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: AppColors.tileLight1, borderRadius: BorderRadius.circular(9)),
                        child: Icon(s['icon'] as IconData, color: AppColors.primary, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s['time'] as String,
                                style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
                            Text(s['place'] as String,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                            Text(s['desc'] as String,
                                style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.tileLight1, borderRadius: BorderRadius.circular(6)),
                        child: Text(s['duration'] as String,
                            style: const TextStyle(fontSize: 9, color: AppColors.primaryDark)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
