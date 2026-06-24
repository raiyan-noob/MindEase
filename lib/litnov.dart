import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NovelData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String bookUrl;

  NovelData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bookUrl,
  });
}

class NovelPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const NovelPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> with WidgetsBindingObserver {
  late final List<NovelData> novels;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    novels = _getNovelDataForFeeling(widget.feeling);
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

  List<NovelData> _getNovelDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          NovelData(
            title: 'The Perks of Being a Wallflower',
            description:
                'A coming-of-age story exploring trauma, anxiety, and the healing power of friendship through heartfelt letters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/22628.The_Perks_of_Being_a_Wallflower',
          ),
          NovelData(
            title: 'Reasons to Stay Alive - Matt Haig',
            description:
                'A memoir-style novel blending fiction and real life about overcoming depression and finding reasons to keep going.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/25733573-reasons-to-stay-alive',
          ),
          NovelData(
            title: 'Girl in Pieces - Kathleen Glasgow',
            description:
                'A raw and emotional story of a young girl recovering from self-harm and rebuilding her life through art.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1541963463532-d68292c34b19?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/29236380-girl-in-pieces',
          ),
          NovelData(
            title: 'The Bell Jar - Sylvia Plath',
            description:
                'A powerful semi-autobiographical novel about a young woman\'s descent into depression and her journey toward recovery.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/book/show/6514.The_Bell_Jar',
          ),
          NovelData(
            title: 'The Kite Runner - Khaled Hosseini',
            description:
                'A powerful story of friendship, betrayal, and redemption set against the backdrop of Afghanistan\'s turbulent history.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/13536.The_Kite_Runner',
          ),
        ];
      case 'Depressed':
        return [
          NovelData(
            title: 'Reasons to Stay Alive - Matt Haig',
            description:
                'A memoir-style novel blending fiction and real life about overcoming depression and finding reasons to keep going.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/25733573-reasons-to-stay-alive',
          ),
          NovelData(
            title: 'The Bell Jar - Sylvia Plath',
            description:
                'A powerful semi-autobiographical novel about a young woman\'s descent into depression and her journey toward recovery.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/book/show/6514.The_Bell_Jar',
          ),
          NovelData(
            title: 'Challenger Deep - Neal Shusterman',
            description:
                'An award-winning novel about a teen navigating schizophrenia, told through vivid imagery and dual narratives.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18075234-challenger-deep',
          ),
          NovelData(
            title: 'A Man Called Ove - Fredrik Backman',
            description:
                'A heartwarming tale of a grumpy old man who rediscovers the joy of living through unexpected friendships.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1519682577862-22b62b24e493?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18774964-a-man-called-ove',
          ),
        ];
      case 'Anxious':
        return [
          NovelData(
            title: 'Turtles All the Way Down - John Green',
            description:
                'A gripping novel about living with OCD, spiraling thoughts, and finding your identity beyond your mental illness.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/35504431-turtles-all-the-way-down',
          ),
          NovelData(
            title: 'Highly Illogical Behavior - John Corey Whaley',
            description:
                'A quirky novel about a teen with agoraphobia and the unexpected friendship that challenges his comfort zone.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/26109391-highly-illogical-behavior',
          ),
          NovelData(
            title: 'All the Bright Places - Jennifer Niven',
            description:
                'A deeply moving love story between two teens who struggle with mental illness and help each other find reasons to live.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1474932430478-367dbb6832c1?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18460392-all-the-bright-places',
          ),
          NovelData(
            title: 'Eleanor Oliphant Is Completely Fine',
            description:
                'A beautiful story of a socially awkward woman who learns that connection and kindness can heal deep wounds.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/31434883-eleanor-oliphant-is-completely-fine',
          ),
        ];
      case 'Frustrated':
        return [
          NovelData(
            title: 'The Midnight Library - Matt Haig',
            description:
                'A magical novel about a woman who gets to explore alternate lives she could have lived, discovering what truly matters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/52578297-the-midnight-library',
          ),
          NovelData(
            title: 'A Man Called Ove - Fredrik Backman',
            description:
                'A heartwarming tale of a grumpy old man who rediscovers the joy of living through unexpected friendships.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1519682577862-22b62b24e493?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18774964-a-man-called-ove',
          ),
          NovelData(
            title: 'The Perks of Being a Wallflower',
            description:
                'A coming-of-age story exploring trauma, anxiety, and the healing power of friendship through heartfelt letters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/22628.The_Perks_of_Being_a_Wallflower',
          ),
          NovelData(
            title: 'Girl in Pieces - Kathleen Glasgow',
            description:
                'A raw and emotional story of a young girl recovering from self-harm and rebuilding her life through art.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1541963463532-d68292c34b19?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/29236380-girl-in-pieces',
          ),
        ];
      case 'Angry':
        return [
          NovelData(
            title: 'It\'s Kind of a Funny Story - Ned Vizzini',
            description:
                'A heartfelt and humorous novel about a teen who checks himself into a psychiatric hospital and discovers hope.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/248704.It_s_Kind_of_a_Funny_Story',
          ),
          NovelData(
            title: 'All the Bright Places - Jennifer Niven',
            description:
                'A deeply moving love story between two teens who struggle with mental illness and help each other find reasons to live.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1474932430478-367dbb6832c1?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18460392-all-the-bright-places',
          ),
          NovelData(
            title: 'The Midnight Library - Matt Haig',
            description:
                'A magical novel about a woman who gets to explore alternate lives she could have lived, discovering what truly matters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/52578297-the-midnight-library',
          ),
          NovelData(
            title: 'A Man Called Ove - Fredrik Backman',
            description:
                'A heartwarming tale of a grumpy old man who rediscovers the joy of living through unexpected friendships.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1519682577862-22b62b24e493?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18774964-a-man-called-ove',
          ),
        ];
      case 'Hopeless':
        return [
          NovelData(
            title: 'Reasons to Stay Alive - Matt Haig',
            description:
                'A memoir-style novel blending fiction and real life about overcoming depression and finding reasons to keep going.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/25733573-reasons-to-stay-alive',
          ),
          NovelData(
            title: 'The Midnight Library - Matt Haig',
            description:
                'A magical novel about a woman who gets to explore alternate lives she could have lived, discovering what truly matters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/52578297-the-midnight-library',
          ),
          NovelData(
            title: 'The Bell Jar - Sylvia Plath',
            description:
                'A powerful semi-autobiographical novel about a young woman\'s descent into depression and her journey toward recovery.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/book/show/6514.The_Bell_Jar',
          ),
          NovelData(
            title: 'Challenger Deep - Neal Shusterman',
            description:
                'An award-winning novel about a teen navigating schizophrenia, told through vivid imagery and dual narratives.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/18075234-challenger-deep',
          ),
        ];
      default:
        return [
          NovelData(
            title: 'The Bell Jar - Sylvia Plath',
            description:
                'A powerful semi-autobiographical novel about a young woman\'s descent into depression and her journey toward recovery.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=300&fit=crop',
            bookUrl: 'https://www.goodreads.com/book/show/6514.The_Bell_Jar',
          ),
          NovelData(
            title: 'It\'s Kind of a Funny Story - Ned Vizzini',
            description:
                'A heartfelt and humorous novel about a teen who checks himself into a psychiatric hospital and discovers hope.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/248704.It_s_Kind_of_a_Funny_Story',
          ),
          NovelData(
            title: 'The Perks of Being a Wallflower',
            description:
                'A coming-of-age story exploring trauma, anxiety, and the healing power of friendship through heartfelt letters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/22628.The_Perks_of_Being_a_Wallflower',
          ),
          NovelData(
            title: 'The Midnight Library - Matt Haig',
            description:
                'A magical novel about a woman who gets to explore alternate lives she could have lived, discovering what truly matters.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&h=300&fit=crop',
            bookUrl:
                'https://www.goodreads.com/book/show/52578297-the-midnight-library',
          ),
        ];
    }
  }

  Widget _buildNovelContainer(NovelData novel, Color accent, bool isLight) {
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
            onTap: () => _launchURL(novel.bookUrl),
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
                    novel.thumbnailUrl,
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
                    novel.title,
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
                    title: novel.title,
                    description: novel.description,
                    link: novel.bookUrl,
                  ),
                  child: Text(
                    novel.description,
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
                '📚 Novels & Stories',
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
              itemCount: novels.length,
              itemBuilder: (context, index) {
                final novel = novels[index];
                return _buildNovelContainer(novel, accent, isLight);
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
