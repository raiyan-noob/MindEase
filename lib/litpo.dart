import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoemData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String bookUrl;

  PoemData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bookUrl,
  });
}

class PoemPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const PoemPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<PoemPage> createState() => _PoemPageState();
}

class _PoemPageState extends State<PoemPage> with WidgetsBindingObserver {
  late final List<PoemData> poems;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    poems = _getPoemDataForFeeling(widget.feeling);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _pendingShowRating) {
      _pendingShowRating = false;
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) _showRatingDialog();
      });
    }
  }

  List<PoemData> _getPoemDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          PoemData(
            title: 'Not Waving but Drowning - Stevie Smith',
            description:
                'A haunting poem about hidden suffering and how people often mask their pain behind a smile.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46479/not-waving-but-drowning',
          ),
          PoemData(
            title: 'Heavy - Mary Oliver',
            description:
                'A short yet profound poem about letting go of the emotional weight we carry and choosing to live fully.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/quotes/7987-heavy',
          ),
          PoemData(
            title: 'Autobiography in Five Chapters - Portia Nelson',
            description:
                'A brilliant metaphorical poem about personal growth, breaking patterns, and choosing a new path in life.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/quotes/7510-autobiography-in-five-short-chapters',
          ),
          PoemData(
            title: 'The Guest House - Rumi',
            description:
                'A beautiful Rumi poem about welcoming all emotions — joy, sorrow, and pain — as unexpected visitors to learn from.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/43568/the-guest-house',
          ),
        ];
      case 'Depressed':
        return [
          PoemData(
            title: 'Still I Rise - Maya Angelou',
            description:
                'A powerful poem about resilience, self-worth, and rising above adversity with unshakable strength and grace.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46446/still-i-rise',
          ),
          PoemData(
            title: 'The Road Not Taken - Robert Frost',
            description:
                'A timeless poem reflecting on life choices, self-discovery, and the courage to take the less traveled path.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1510797215324-95aa89f43c33?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/44272/the-road-not-taken',
          ),
          PoemData(
            title: 'Quotes on Depression & Hope',
            description:
                '"Even the darkest night will end and the sun will rise." — Victor Hugo. A collection of quotes to light your way.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1518611505868-48a8f8f22ca3?w=400&h=300&fit=crop',
            bookUrl: 'https://www.verywellmind.com/depression-quotes-5094454',
          ),
          PoemData(
            title: 'Love After Love - Derek Walcott',
            description:
                'A beautiful poem about rediscovering yourself after hardship and learning to love who you truly are again.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/53489/love-after-love',
          ),
        ];
      case 'Anxious':
        return [
          PoemData(
            title: 'Invictus - William Ernest Henley',
            description:
                'I am the master of my fate, I am the captain of my soul — an iconic poem about inner strength and determination.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&h=300&fit=crop',
            bookUrl: 'https://www.poetryfoundation.org/poems/51642/invictus',
          ),
          PoemData(
            title: 'Quotes on Anxiety & Courage',
            description:
                '"You don\'t have to control your thoughts. You just have to stop letting them control you." — Dan Millman',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1489533119213-66a5cd877091?w=400&h=300&fit=crop',
            bookUrl: 'https://www.verywellmind.com/anxiety-quotes-5094498',
          ),
          PoemData(
            title: 'The Guest House - Rumi',
            description:
                'A beautiful Rumi poem about welcoming all emotions — joy, sorrow, and pain — as unexpected visitors to learn from.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/43568/the-guest-house',
          ),
          PoemData(
            title: 'Wild Geese - Mary Oliver',
            description:
                'You do not have to be good. A gentle reminder that you belong in this world just as you are, imperfections and all.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1508672019048-805c876b67e2?w=400&h=300&fit=crop',
            bookUrl: 'https://www.poetryfoundation.org/poems/48568/wild-geese',
          ),
        ];
      case 'Frustrated':
        return [
          PoemData(
            title: 'Quotes on Strength & Resilience',
            description:
                '"The human capacity for burden is like bamboo — far more flexible than you\'d ever believe." — Jodi Picoult',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1519834785169-98be25ec3f84?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/quotes/tag/resilience',
          ),
          PoemData(
            title: 'Brave - Sara Bareilles',
            description:
                'Wait, that is a song; we should instead include a poem focusing on overcoming frustration.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46013/as-we-grow-older',
          ),
          PoemData(
            title: 'If - Rudyard Kipling',
            description:
                'A father\'s timeless advice to his son about keeping calm, staying strong, and never losing faith in yourself.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1491841550275-ad7854e35ca6?w=400&h=300&fit=crop',
            bookUrl: 'https://www.poetryfoundation.org/poems/46473/if---',
          ),
          PoemData(
            title: 'Autobiography in Five Chapters - Portia Nelson',
            description:
                'A brilliant metaphorical poem about personal growth, breaking patterns, and choosing a new path in life.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/quotes/7510-autobiography-in-five-short-chapters',
          ),
        ];
      case 'Angry':
        return [
          PoemData(
            title: 'Still I Rise - Maya Angelou',
            description:
                'A powerful poem about resilience, self-worth, and rising above adversity with unshakable strength and grace.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46446/still-i-rise',
          ),
          PoemData(
            title: 'If - Rudyard Kipling',
            description:
                'A father\'s timeless advice to his son about keeping calm, staying strong, and never losing faith in yourself.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1491841550275-ad7854e35ca6?w=400&h=300&fit=crop',
            bookUrl: 'https://www.poetryfoundation.org/poems/46473/if---',
          ),
          PoemData(
            title: 'The Guest House - Rumi',
            description:
                'A beautiful Rumi poem about welcoming all emotions — joy, sorrow, and pain — as unexpected visitors to learn from.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/43568/the-guest-house',
          ),
          PoemData(
            title: 'Not Waving but Drowning - Stevie Smith',
            description:
                'A haunting poem about hidden suffering and how people often mask their pain behind a smile.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46479/not-waving-but-drowning',
          ),
        ];
      case 'Hopeless':
        return [
          PoemData(
            title: 'Desiderata - Max Ehrmann',
            description:
                'A timeless prose poem offering gentle life advice about peace, patience, and being kind to yourself.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=300&fit=crop',
            bookUrl: 'https://www.desiderata.com/desiderata.html',
          ),
          PoemData(
            title: 'Love After Love - Derek Walcott',
            description:
                'A beautiful poem about rediscovering yourself after hardship and learning to love who you truly are again.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/53489/love-after-love',
          ),
          PoemData(
            title: 'Still I Rise - Maya Angelou',
            description:
                'A powerful poem about resilience, self-worth, and rising above adversity with unshakable strength and grace.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46446/still-i-rise',
          ),
          PoemData(
            title: 'The Guest House - Rumi',
            description:
                'A beautiful Rumi poem about welcoming all emotions — joy, sorrow, and pain — as unexpected visitors to learn from.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/43568/the-guest-house',
          ),
        ];
      default:
        return [
          PoemData(
            title: 'Still I Rise - Maya Angelou',
            description:
                'A powerful poem about resilience, self-worth, and rising above adversity with unshakable strength and grace.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46446/still-i-rise',
          ),
          PoemData(
            title: 'The Guest House - Rumi',
            description:
                'A beautiful Rumi poem about welcoming all emotions — joy, sorrow, and pain — as unexpected visitors to learn from.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.poetryfoundation.org/poems/43568/the-guest-house',
          ),
          PoemData(
            title: 'Invictus - William Ernest Henley',
            description:
                'I am the master of my fate, I am the captain of my soul — an iconic poem about inner strength and determination.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&h=300&fit=crop',
            bookUrl: 'https://www.poetryfoundation.org/poems/51642/invictus',
          ),
          PoemData(
            title: 'Quotes on Self-Love & Healing',
            description:
                '"You yourself, as much as anybody in the entire universe, deserve your love and affection." — Buddha',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/quotes/tag/self-love',
          ),
        ];
    }
  }

  Widget _buildPoemContainer(PoemData poem, Color accent, bool isLight) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: accent, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: isLight
            ? Colors.white.withOpacity(0.85)
            : Colors.black.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.5),
            blurRadius: 6,
            offset: Offset(1, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _launchURL(poem.bookUrl),
            child: Container(
              width: 108,
              height: 82,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    poem.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: accent.withOpacity(0.2),
                        child: Icon(Icons.book, color: accent, size: 40),
                      );
                    },
                  ),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.menu_book, color: Colors.white, size: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Text(
                    poem.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () => _showDescriptionDialog(
                    title: poem.title,
                    description: poem.description,
                    link: poem.bookUrl,
                  ),
                  child: Text(
                    poem.description,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      color: isLight
                          ? Color.fromRGBO(70, 70, 70, 1.0)
                          : Color.fromRGBO(200, 200, 200, 1.0),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDescriptionDialog({
    required String title,
    required String description,
    required String link,
  }) {
    final bool isLight = widget.isLightNotifier.value;
    final Color accent = isLight
        ? Color.fromRGBO(16, 100, 56, 1.0)
        : Color.fromRGBO(184, 220, 193, 1.0);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          backgroundColor: isLight
              ? Colors.white
              : Color.fromRGBO(30, 30, 30, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: accent, width: 2),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: accent,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
                color: isLight
                    ? Color.fromRGBO(35, 35, 35, 1.0)
                    : Color.fromRGBO(220, 220, 220, 1.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(color: accent)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _launchURL(link);
              },
              style: ElevatedButton.styleFrom(backgroundColor: accent),
              child: Text(
                'Start Healing✨',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  color: isLight
                      ? Color.fromRGBO(220, 220, 220, 1.0)
                      : Color.fromRGBO(35, 35, 35, 1.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRatingDialog() {
    final bool isLight = widget.isLightNotifier.value;
    final Color accent = isLight
        ? Color.fromRGBO(16, 100, 56, 1.0)
        : Color.fromRGBO(184, 220, 193, 1.0);

    String? selectedEmoji;

    final Map<String, String> ratingOptions = {
      '😞': 'Worse',
      '😔': 'Bad',
      '😐': 'Same',
      '😊': 'Better',
      '😄': 'Great',
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              backgroundColor: isLight
                  ? Colors.white
                  : Color.fromRGBO(30, 30, 30, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: accent, width: 2),
              ),
              title: Column(
                children: [
                  Text(
                    'Was it helpful?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(color: accent.withOpacity(0.4), thickness: 2),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rate how you are feeling now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isLight
                          ? Color.fromRGBO(70, 70, 70, 1.0)
                          : Color.fromRGBO(200, 200, 200, 1.0),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: ratingOptions.entries.map((entry) {
                      final String emoji = entry.key;
                      final String label = entry.value;
                      final bool isSelected = selectedEmoji == emoji;

                      return GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            selectedEmoji = emoji;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? accent.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? accent : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                emoji,
                                style: TextStyle(
                                  fontSize: isSelected ? 32 : 26,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                label,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.bold,
                                  color: isSelected
                                      ? accent
                                      : (isLight
                                            ? Color.fromRGBO(52, 52, 52, 1)
                                            : Color.fromRGBO(
                                                170,
                                                170,
                                                170,
                                                1.0,
                                              )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  if (selectedEmoji != null)
                    Text(
                      _getRatingMessage(selectedEmoji!),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: accent,
                      ),
                    ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: accent.withOpacity(0.7),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isLight
                              ? Color.fromRGBO(61, 61, 61, 1)
                              : Color.fromRGBO(170, 170, 170, 1.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: selectedEmoji != null
                          ? () {
                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        disabledBackgroundColor: accent.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isLight
                              ? Colors.white
                              : Color.fromRGBO(30, 30, 30, 1.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        );
      },
    );
  }

  String _getRatingMessage(String emoji) {
    switch (emoji) {
      case '😞':
        return "We're sorry to hear that. 💛\nWe're here for you.";
      case '😔':
        return "Hang in there. 🌿\nIt's okay to not be okay.";
      case '😐':
        return "That's alright. 🤍\nSmall steps still count.";
      case '😊':
        return "That's wonderful! 🌱\nYou're doing great.";
      case '😄':
        return "Amazing! 🌟\nSo glad it helped you!";
      default:
        return "";
    }
  }

  Future<void> _launchURL(String url) async {
    String normalized = url.trim();
    if (!normalized.contains('://')) normalized = 'https://' + normalized;
    final uri = Uri.tryParse(normalized);
    if (uri == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid URL: $url')));
      return;
    }

    try {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
      if (launched) {
        _pendingShowRating = true;
        return;
      }
    } catch (_) {}

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Unable to open link: $url')));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        isLight
            ? Color.fromRGBO(255, 255, 255, 1.0)
            : Color.fromRGBO(19, 19, 19, 1.0);
        final accent = isLight
            ? Color.fromRGBO(16, 100, 56, 1.0)
            : Color.fromRGBO(184, 220, 193, 1.0);

        return Scaffold(
          backgroundColor: isLight
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 0, 0, 0),
          appBar: AppBar(
            backgroundColor: isLight
                ? Color.fromARGB(255, 220, 239, 219)
                : Color.fromARGB(255, 34, 34, 34),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isLight ? Colors.black : accent,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),

              decoration: BoxDecoration(
                border: Border.all(
                  color: isLight
                      ? Color.fromRGBO(16, 100, 56, 1.0)
                      : Color.fromRGBO(184, 220, 193, 1.0),
                  width: 3,
                ),
                color: isLight
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromRGBO(14, 14, 14, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '📜 Poems & Quotes',
                style: TextStyle(
                  color: isLight
                      ? Color.fromRGBO(16, 100, 56, 1.0)
                      : Color.fromRGBO(184, 220, 193, 1.0),
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: GestureDetector(
                  onTap: () {
                    widget.onThemeChanged(!isLight);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLight
                          ? Color.fromRGBO(255, 255, 255, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.6),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          RotationTransition(turns: animation, child: child),
                      child: Icon(
                        isLight ? Icons.light_mode : Icons.dark_mode,
                        key: ValueKey(isLight),
                        color: isLight
                            ? Color.fromRGBO(16, 100, 56, 1)
                            : Color.fromRGBO(184, 220, 193, 1),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                16,
                20,
                16,
                MediaQuery.of(context).padding.bottom + 20,
              ),
              itemCount: poems.length,
              itemBuilder: (context, index) {
                final poem = poems[index];
                return _buildPoemContainer(poem, accent, isLight);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ),

          /*endDrawer: Drawer(
            width: 250,
            elevation: 30,
            backgroundColor: isLight
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 19, 19, 19),
            shadowColor: isLight
                ? Color.fromARGB(255, 4, 13, 9)
                : Color.fromARGB(255, 184, 220, 193),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: isLight
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Color.fromARGB(255, 19, 19, 19),
                    ),
                    icon: Icon(
                      Icons.person,
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 184, 220, 193),
                      size: 25,
                    ),
                    label: Text(
                      'Profile',

                      style: TextStyle(
                        color: isLight
                            ? Color.fromARGB(255, 16, 100, 56)
                            : Color.fromARGB(255, 184, 220, 193),
                        fontFamily: 'Nunito',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '-------------------------',
                    style: TextStyle(
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 184, 220, 193),
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isLight
                                ? Color.fromARGB(255, 16, 100, 56)
                                : Color.fromARGB(255, 184, 220, 193),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onThemeChanged(true);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isLight
                                      ? Color.fromARGB(255, 16, 100, 56)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Icon(
                                  Icons.light_mode,
                                  color: isLight
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(255, 184, 220, 193),
                                  size: 24,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onThemeChanged(false);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !isLight
                                      ? Color.fromARGB(255, 184, 220, 193)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.dark_mode,
                                  color: !isLight
                                      ? Color.fromARGB(255, 42, 42, 42)
                                      : Color.fromARGB(255, 16, 100, 56),
                                  size: 24,
                                ),
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
          ),*/
        );
      },
    );
  }
}
