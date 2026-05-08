import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/demo_data.dart';
import '../widgets/premium_widgets.dart';

class AudioTourScreen extends StatefulWidget {
  const AudioTourScreen({super.key});

  @override
  State<AudioTourScreen> createState() => _AudioTourScreenState();
}

class _AudioTourScreenState extends State<AudioTourScreen> {
  bool playing = false;
  double progress = .38;

  @override
  Widget build(BuildContext context) {
    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI Audio Tour', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(
            'Narration, questions, and local context in your pocket.',
            style: TextStyle(color: adaptiveMutedColor(context, .62)),
          ),
          const SizedBox(height: 18),
          GlassCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(
                  height: 260,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        child: Image.network(DemoImages.fort, fit: BoxFit.cover),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(.76)]),
                        ),
                      ),
                      const Positioned(
                        left: 18,
                        right: 18,
                        bottom: 18,
                        child: Text('Gateway of India: stories from the sea', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Waveform(active: playing),
                      Slider(value: progress, onChanged: (v) => setState(() => progress = v), activeColor: AppColors.accent),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.replay_10_rounded)),
                          const SizedBox(width: 12),
                          IconButton.filled(
                            style: IconButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: AppColors.primaryDeep),
                            iconSize: 38,
                            onPressed: () => setState(() => playing = !playing),
                            icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                          ),
                          const SizedBox(width: 12),
                          IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.forward_10_rounded)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'AI Narration'),
          GlassCard(
            child: Text(
              'This monument watched ships, empires, migrants, and festivals pass through the same stone arch. Ask anything as you walk and I will adjust the story to your pace.',
              style: TextStyle(height: 1.55, color: adaptiveMutedColor(context, .72)),
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Row(
              children: [
                const Expanded(
                  child: TextField(decoration: InputDecoration(hintText: 'Ask the guide a question')),
                ),
                const SizedBox(width: 10),
                IconButton.filled(onPressed: () {}, icon: const Icon(Icons.send_rounded)),
              ],
            ),
          ),
          const SectionHeader(title: 'More Tours Nearby'),
          ...['Borra Caves', 'Charminar', 'Old Harbor Walk'].map(
            (t) => GlassCard(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(Icons.graphic_eq_rounded, color: AppColors.accent),
                  const SizedBox(width: 12),
                  Expanded(child: Text(t, style: const TextStyle(fontWeight: FontWeight.w800))),
                  TextButton(onPressed: () {}, child: const Text('Start')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
