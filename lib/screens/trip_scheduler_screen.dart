import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/premium_widgets.dart';

class TripSchedulerScreen extends StatefulWidget {
  const TripSchedulerScreen({super.key});

  @override
  State<TripSchedulerScreen> createState() => _TripSchedulerScreenState();
}

class _TripSchedulerScreenState extends State<TripSchedulerScreen> {
  final days = ['Day 1', 'Day 2', 'Day 3', 'Day 4'];
  int selectedDay = 0;
  final tasks = ['Sunrise viewpoint', 'Cafe breakfast', 'Heritage walk', 'Hidden beach', 'Audio tour'];

  @override
  Widget build(BuildContext context) {
    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trip Scheduler', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(
            'Day-wise AI planner with budget and export controls.',
            style: TextStyle(color: adaptiveMutedColor(context, .62)),
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Row(
              children: [
                const Icon(Icons.calendar_month_rounded, color: AppColors.accent, size: 34),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vizag discovery plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      Text(
                        'May 16 - May 19, 2026',
                        style: TextStyle(color: adaptiveMutedColor(context, .62), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.ios_share_rounded)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(selected: selectedDay == i, label: Text(days[i]), onSelected: (_) => setState(() => selectedDay = i)),
              ),
            ),
          ),
          const SectionHeader(title: 'Drag & Drop Itinerary'),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            onReorder: (oldIndex, newIndex) => setState(() {
              if (newIndex > oldIndex) newIndex--;
              final item = tasks.removeAt(oldIndex);
              tasks.insert(newIndex, item);
            }),
            itemBuilder: (_, i) => GlassCard(
              key: ValueKey(tasks[i]),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.accent.withOpacity(.18),
                    child: Text('${i + 1}', style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tasks[i],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Icon(Icons.drag_handle_rounded, color: adaptiveFaintColor(context)),
                ],
              ),
            ),
          ),
          const SectionHeader(title: 'Budget Tracker'),
          GlassCard(
            child: Column(
              children: [
                _Budget('Stay', 6200, .62, AppColors.accent),
                _Budget('Food', 2400, .42, AppColors.secondary),
                _Budget('Activities', 3800, .76, AppColors.xpGold),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: GradientButton(label: 'Save Plan', icon: Icons.bookmark_rounded, onPressed: () {})),
                    const SizedBox(width: 10),
                    Expanded(child: GradientButton(label: 'Export', icon: Icons.picture_as_pdf_rounded, gradient: AppColors.cyanGradient, onPressed: () {})),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Budget extends StatelessWidget {
  final String label;
  final int amount;
  final double value;
  final Color color;
  const _Budget(this.label, this.amount, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'INR $amount',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: color, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              color: color,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white12
                  : AppColors.textMuted.withOpacity(.18),
            ),
          ),
        ],
      ),
    );
  }
}
