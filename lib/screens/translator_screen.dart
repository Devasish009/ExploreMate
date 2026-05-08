import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/premium_widgets.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  String from = 'English';
  String to = 'Hindi';
  final languages = const [
    'Afrikaans',
    'Albanian',
    'Amharic',
    'Arabic',
    'Armenian',
    'Assamese',
    'Aymara',
    'Azerbaijani',
    'Bambara',
    'Basque',
    'Belarusian',
    'Bengali',
    'Bhojpuri',
    'Bosnian',
    'Bulgarian',
    'Catalan',
    'Cebuano',
    'Chinese Simplified',
    'Chinese Traditional',
    'Corsican',
    'Croatian',
    'Czech',
    'Danish',
    'Dogri',
    'Dutch',
    'English',
    'Esperanto',
    'Estonian',
    'Ewe',
    'Filipino',
    'Finnish',
    'French',
    'Frisian',
    'Galician',
    'Georgian',
    'German',
    'Greek',
    'Guarani',
    'Gujarati',
    'Haitian Creole',
    'Hausa',
    'Hawaiian',
    'Hebrew',
    'Hindi',
    'Hmong',
    'Hungarian',
    'Icelandic',
    'Igbo',
    'Ilocano',
    'Indonesian',
    'Irish',
    'Italian',
    'Japanese',
    'Javanese',
    'Kannada',
    'Kazakh',
    'Khmer',
    'Kinyarwanda',
    'Konkani',
    'Korean',
    'Krio',
    'Kurdish Kurmanji',
    'Kurdish Sorani',
    'Kyrgyz',
    'Lao',
    'Latin',
    'Latvian',
    'Lingala',
    'Lithuanian',
    'Luganda',
    'Luxembourgish',
    'Macedonian',
    'Maithili',
    'Malagasy',
    'Malay',
    'Malayalam',
    'Maltese',
    'Manipuri',
    'Maori',
    'Marathi',
    'Meiteilon',
    'Mizo',
    'Mongolian',
    'Myanmar Burmese',
    'Nepali',
    'Norwegian',
    'Nyanja',
    'Odia',
    'Oromo',
    'Pashto',
    'Persian',
    'Polish',
    'Portuguese',
    'Punjabi',
    'Quechua',
    'Romanian',
    'Russian',
    'Samoan',
    'Sanskrit',
    'Scots Gaelic',
    'Sepedi',
    'Serbian',
    'Sesotho',
    'Shona',
    'Sindhi',
    'Sinhala',
    'Slovak',
    'Slovenian',
    'Somali',
    'Spanish',
    'Sundanese',
    'Swahili',
    'Swedish',
    'Tagalog',
    'Tajik',
    'Tamil',
    'Tatar',
    'Telugu',
    'Thai',
    'Tigrinya',
    'Tsonga',
    'Turkish',
    'Turkmen',
    'Twi',
    'Ukrainian',
    'Urdu',
    'Uyghur',
    'Uzbek',
    'Vietnamese',
    'Welsh',
    'Xhosa',
    'Yiddish',
    'Yoruba',
    'Zulu',
  ];

  @override
  Widget build(BuildContext context) {
    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(title: 'Live Translator', subtitle: 'Text, voice, and camera-ready travel translation.'),
          const SizedBox(height: 18),
          GlassCard(
            child: Row(
              children: [
                Expanded(child: _LanguageDrop(value: from, list: languages, onChanged: (v) => setState(() => from = v))),
                IconButton(
                  tooltip: 'Swap languages',
                  onPressed: () => setState(() {
                    final old = from;
                    from = to;
                    to = old;
                  }),
                  icon: const Icon(Icons.swap_horiz_rounded, color: AppColors.accent),
                ),
                Expanded(child: _LanguageDrop(value: to, list: languages, onChanged: (v) => setState(() => to = v))),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Say or type something', style: TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                const TextField(
                  minLines: 4,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: 'Where is the nearest metro station?'),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: GradientButton(label: 'Translate', icon: Icons.translate_rounded, onPressed: () {})),
                    const SizedBox(width: 10),
                    IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.mic_rounded)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hindi output', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                const Text('Sabse najdeeki metro station kahan hai?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.volume_up_rounded)),
                    IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.copy_rounded)),
                    const Spacer(),
                    const SkeletonLine(width: 92),
                  ],
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'Camera Preview'),
          GlassCard(
            padding: EdgeInsets.zero,
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(colors: [AppColors.cardBg, AppColors.primary]),
              ),
              child: Stack(
                children: [
                  Center(child: Icon(Icons.document_scanner_rounded, color: adaptiveFaintColor(context), size: 74)),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(border: Border.all(color: AppColors.accent), borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28,
                    right: 28,
                    bottom: 28,
                    child: Text('Point at menus, boards, and tickets for instant overlay translation.', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Header({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        Text(subtitle, style: TextStyle(color: adaptiveMutedColor(context, .62))),
      ],
    );
  }
}

class _LanguageDrop extends StatelessWidget {
  final String value;
  final List<String> list;
  final ValueChanged<String> onChanged;
  const _LanguageDrop({required this.value, required this.list, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: AppColors.cardBg,
        items: list
            .map(
              (l) => DropdownMenuItem(
                value: l,
                child: Text(l, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}
