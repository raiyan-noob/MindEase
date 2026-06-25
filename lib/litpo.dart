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
            title: 'Desiderata',
            description:
                'A timeless prose poem offering wisdom about peace, self-acceptance, patience, and finding meaning in life. Many people revisit it during periods of sadness and uncertainty.',
            thumbnailUrl: 'https://www.desiderata.com/images/desiderata.jpg',
            bookUrl: 'https://www.desiderata.com/desiderata.html',
          ),

          PoemData(
            title: 'Invictus',
            description:
                'Written by William Ernest Henley during a period of severe illness, this powerful poem speaks about resilience, courage, and refusing to surrender to despair.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?w=800',
            bookUrl: 'https://www.poetryfoundation.org/poems/51642/invictus',
          ),

          PoemData(
            title: 'Kindness',
            description:
                'Naomi Shihab Nye’s famous poem explores how loss and sadness can deepen our understanding of compassion and human connection. Many readers find it comforting during difficult periods.',
            thumbnailUrl:
                'https://poets.org/sites/default/files/images/biographies/NaomiShihabNye_NewBioPhoto.png',
            bookUrl: 'https://poets.org/poem/kindness',
          ),

          PoemData(
            title: 'If',
            description:
                'Rudyard Kipling’s classic poem encourages emotional balance, patience, perseverance, and dignity during adversity. It remains one of the most shared inspirational poems in the world.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800',
            bookUrl: 'https://www.poetryfoundation.org/poems/46473/if---',
          ),

          PoemData(
            title: 'Healing Quotes Collection',
            description:
                'A carefully curated collection of quotes about healing, hope, grief, resilience, and emotional recovery. Useful for readers seeking short but meaningful encouragement.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/healing',
          ),
        ];
      case 'Depressed':
        return [
          PoemData(
            title: 'Still I Rise',
            description:
                'Maya Angelou’s iconic poem about resilience, dignity, and rising above pain. Its message of perseverance has inspired countless readers facing depression, self-doubt, and emotional hardship.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46446/still-i-rise',
          ),

          PoemData(
            title: 'The Guest House',
            description:
                'A profound poem by Rumi that encourages people to welcome every emotion, including sadness and despair, as part of the human experience. Many readers find it comforting during periods of depression and emotional struggle.',
            thumbnailUrl:
                'https://ap-pics2.gotpoem.com/ap-pics/user/4913/439.jpg?137x190',
            bookUrl:
                'https://allpoetry.com/poem/8534703-The-Guest-House-by-Mewlana-Jalaluddin-Rumi',
          ),

          PoemData(
            title: 'Wild Geese',
            description:
                'Mary Oliver’s beloved poem reminds readers that they do not have to be perfect to deserve love and belonging. It is frequently recommended by therapists and mental health communities.',
            thumbnailUrl:
                'https://ap-pics2.gotpoem.com/ap-pics/user/5964/343.jpg?SymeMaryOliverjpg8',
            bookUrl:
                'https://allpoetry.com/poem/15374223-Wild-geese-by-Mary-J-Oliver',
          ),

          PoemData(
            title: 'Recovery Quotes Collection',
            description:
                'A collection of quotes about healing, recovery, resilience, and overcoming difficult periods. Readers often find encouragement in the stories and wisdom shared by others who faced similar challenges.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/recovery',
          ),

          PoemData(
            title: 'Mental Health Quotes Collection',
            description:
                'A curated selection of quotes focused on emotional well-being, self-acceptance, resilience, and hope. Helpful for readers looking for brief but meaningful reminders that recovery is possible.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/mental-health',
          ),

          PoemData(
            title: 'Inspirational Quotes About Strength',
            description:
                'An extensive collection of quotes about inner strength, perseverance, and overcoming adversity. Particularly useful during times when motivation and hope feel difficult to maintain.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/strength',
          ),
        ];
      case 'Anxious':
        return [
          PoemData(
            title: 'The Peace of Wild Things',
            description:
                'Wendell Berry’s beloved poem about finding peace in nature when anxiety and fear become overwhelming. Many readers return to it during stressful periods because of its calming and grounding message.',
            thumbnailUrl:
                'https://www.scottishpoetrylibrary.org.uk/wp-content/themes/spl2023/img/chars/single/B.svg',
            bookUrl:
                'https://www.scottishpoetrylibrary.org.uk/poem/peace-wild-things/',
          ),

          PoemData(
            title: 'The Guest House',
            description:
                'A profound poem by Rumi that encourages people to welcome every emotion, including sadness and despair, as part of the human experience. Many readers find it comforting during periods of depression and emotional struggle.',
            thumbnailUrl:
                'https://ap-pics2.gotpoem.com/ap-pics/user/4913/439.jpg?137x190',
            bookUrl:
                'https://allpoetry.com/poem/8534703-The-Guest-House-by-Mewlana-Jalaluddin-Rumi',
          ),
          PoemData(
            title: 'Mindfulness Quotes Collection',
            description:
                'A curated collection of quotes about mindfulness, awareness, and living in the present moment. These insights can help interrupt cycles of overthinking and anxious rumination.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/mindfulness',
          ),

          PoemData(
            title: 'Inner Peace Quotes Collection',
            description:
                'A selection of quotes from philosophers, spiritual teachers, and writers focused on cultivating calmness, acceptance, and emotional balance.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/inner-peace',
          ),

          PoemData(
            title: 'Anxiety Quotes Collection',
            description:
                'A collection of reflections and quotes from people who have experienced anxiety themselves. Many readers find comfort in knowing others have faced similar fears and found ways to cope.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/anxiety',
          ),
        ];
      case 'Frustrated':
        return [
          PoemData(
            title: 'If—',
            description:
                'Rudyard Kipling’s classic poem teaches patience, self-control, perseverance, and resilience in the face of setbacks. It is one of the most quoted poems for people struggling with frustration and adversity.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800',
            bookUrl: 'https://www.poetryfoundation.org/poems/46473/if---',
          ),

          PoemData(
            title: 'Invictus',
            description:
                'Written by William Ernest Henley during a period of severe illness, this powerful poem speaks about resilience, courage, and refusing to surrender to despair.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?w=800',
            bookUrl: 'https://www.poetryfoundation.org/poems/51642/invictus',
          ),
          PoemData(
            title: 'Perseverance Quotes Collection',
            description:
                'A collection of quotes from leaders, athletes, writers, and thinkers about persistence, determination, and continuing despite obstacles. Ideal for moments when frustration threatens motivation.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/perseverance',
          ),

          PoemData(
            title: 'Motivational Quotes Collection',
            description:
                'An extensive collection of motivational quotes that encourage persistence, effort, and positive action when progress feels slow or obstacles seem overwhelming.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/motivation',
          ),

          PoemData(
            title: 'Determination Quotes Collection',
            description:
                'Quotes focused on determination, grit, and maintaining momentum during difficult periods. Helpful for readers who feel discouraged by repeated setbacks or challenges.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1516302752625-fcc3c50ae61f?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/determination',
          ),
        ];
      case 'Angry':
        return [
          PoemData(
            title: 'A Psalm of Life',
            description:
                'Henry Wadsworth Longfellow’s inspirational poem encourages action, courage, and purpose instead of dwelling on resentment or negativity. It inspires readers to channel emotional energy into meaningful living.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800',
            bookUrl:
                'https://www.poetryfoundation.org/poems/44644/a-psalm-of-life',
          ),

          PoemData(
            title: 'Forgiveness Quotes Collection',
            description:
                'A carefully curated collection of quotes about forgiveness, letting go of resentment, and finding peace after being hurt. Many readers find these reflections helpful when anger feels difficult to release.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/forgiveness',
          ),

          PoemData(
            title: 'Peace Quotes Collection',
            description:
                'An extensive collection of quotes focused on inner peace, calmness, and emotional balance. These reminders encourage readers to step away from anger and reconnect with tranquility.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/peace',
          ),

          PoemData(
            title: 'Patience Quotes Collection',
            description:
                'Quotes from philosophers, spiritual teachers, and writers emphasizing patience, understanding, and self-control. Particularly helpful when anger arises from impatience or unmet expectations.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/patience',
          ),

          PoemData(
            title: 'Compassion Quotes Collection',
            description:
                'A collection of quotes highlighting empathy, kindness, and compassion toward ourselves and others. These perspectives can soften anger and encourage healthier responses to conflict.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/compassion',
          ),
        ];
      case 'Hopeless':
        return [
          PoemData(
            title: 'Hope is the Thing with Feathers',
            description:
                'Emily Dickinson’s most famous poem about hope. It portrays hope as a small bird that never stops singing, even during life’s harshest storms. Many readers turn to this poem when they need a reminder that hope can survive even in the darkest moments.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1510936111840-65e151ad71bb?w=800',
            bookUrl:
                'https://www.poetryfoundation.org/poems/42889/hope-is-the-thing-with-feathers-314',
          ),

          PoemData(
            title: 'Invictus',
            description:
                'A timeless poem of resilience and determination written by William Ernest Henley while facing serious illness. Its message reminds readers that circumstances may be difficult, but they still possess inner strength and courage.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?w=800',
            bookUrl: 'https://www.poetryfoundation.org/poems/51642/invictus',
          ),

          PoemData(
            title: 'Still I Rise',
            description:
                'Maya Angelou’s powerful poem celebrates resilience, self-worth, and the refusal to be defeated. It has inspired millions of people facing hardship, rejection, or hopelessness.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800',
            bookUrl:
                'https://www.poetryfoundation.org/poems/46446/still-i-rise',
          ),

          PoemData(
            title: 'Hope Quotes Collection',
            description:
                'A carefully curated collection of quotes about hope, perseverance, and believing in a brighter future. These reflections come from writers, leaders, philosophers, and survivors who overcame adversity.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/hope',
          ),

          PoemData(
            title: 'Resilience Quotes Collection',
            description:
                'An inspiring collection of quotes about recovering from setbacks, adapting to challenges, and continuing forward despite difficulties. Ideal for moments when life feels overwhelming.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/resilience',
          ),

          PoemData(
            title: 'Inspirational Quotes Collection',
            description:
                'A broad collection of uplifting quotes about purpose, growth, faith, and overcoming challenges. Many readers revisit these quotes when they need encouragement and perspective.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
            bookUrl: 'https://www.goodreads.com/quotes/tag/inspirational',
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
