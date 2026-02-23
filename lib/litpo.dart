import 'package:flutter/material.dart';

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

class _PoemPageState extends State<PoemPage> {
  List<PoemData> poems = [
    // Healing & Hope Poems
    PoemData(
      title: 'Still I Rise - Maya Angelou',
      description:
          'A powerful poem about resilience, self-worth, and rising above adversity with unshakable strength and grace.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
      bookUrl: 'https://www.poetryfoundation.org/poems/46446/still-i-rise',
    ),
    PoemData(
      title: 'The Guest House - Rumi',
      description:
          'A beautiful Rumi poem about welcoming all emotions — joy, sorrow, and pain — as unexpected visitors to learn from.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=400&h=300&fit=crop',
      bookUrl: 'https://www.poetryfoundation.org/poems/43568/the-guest-house',
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
      title: 'The Road Not Taken - Robert Frost',
      description:
          'A timeless poem reflecting on life choices, self-discovery, and the courage to take the less traveled path.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1510797215324-95aa89f43c33?w=400&h=300&fit=crop',
      bookUrl:
          'https://www.poetryfoundation.org/poems/44272/the-road-not-taken',
    ),

    // Mental Health Awareness Poems
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

    // Inspirational Quotes Collections
    PoemData(
      title: 'Quotes on Anxiety & Courage',
      description:
          '"You don\'t have to control your thoughts. You just have to stop letting them control you." — Dan Millman',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1489533119213-66a5cd877091?w=400&h=300&fit=crop',
      bookUrl: 'https://www.verywellmind.com/anxiety-quotes-5094498',
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
      title: 'Quotes on Self-Love & Healing',
      description:
          '"You yourself, as much as anybody in the entire universe, deserve your love and affection." — Buddha',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
      bookUrl: 'https://www.goodreads.com/quotes/tag/self-love',
    ),
    PoemData(
      title: 'Quotes on Strength & Resilience',
      description:
          '"The human capacity for burden is like bamboo — far more flexible than you\'d ever believe." — Jodi Picoult',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1519834785169-98be25ec3f84?w=400&h=300&fit=crop',
      bookUrl: 'https://www.goodreads.com/quotes/tag/resilience',
    ),

    // Soothing & Mindfulness Poems
    PoemData(
      title: 'Wild Geese - Mary Oliver',
      description:
          'You do not have to be good. A gentle reminder that you belong in this world just as you are, imperfections and all.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1508672019048-805c876b67e2?w=400&h=300&fit=crop',
      bookUrl: 'https://www.poetryfoundation.org/poems/48568/wild-geese',
    ),
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
      bookUrl: 'https://www.poetryfoundation.org/poems/53489/love-after-love',
    ),
    PoemData(
      title: 'If - Rudyard Kipling',
      description:
          'A father\'s timeless advice to his son about keeping calm, staying strong, and never losing faith in yourself.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1491841550275-ad7854e35ca6?w=400&h=300&fit=crop',
      bookUrl: 'https://www.poetryfoundation.org/poems/46473/if---',
    ),
  ];
  Widget _buildPoemContainer(PoemData poem, Color accent, bool isLight) {
    return Container(
      height: 135,
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

                Text(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Open Page'),
        content: Text('Would you like to open this page?\n\n$url'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Open'),
          ),
        ],
      ),
    );
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
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ...poems.map(
                  (poem) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildPoemContainer(poem, accent, isLight),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          endDrawer: Drawer(
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
          ),
        );
      },
    );
  }
}
