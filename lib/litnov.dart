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
            title: 'The Alchemist',
            description:
                'Paulo Coelho’s beloved novel follows a young shepherd on a journey of self-discovery, purpose, and hope. Many readers turn to this book during difficult times because it reminds them that life still holds meaning and possibilities.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqiaY9ClSwmCuPl7hKZHEF_88SX-NG8o3RsOy1Lbt5H2th4l6svlv9sPx_4ANAh4vAitLoFLLHUa9rGuAg3DCWIDtWtsiGVNXawKoAWeV1&s=10',
            bookUrl:
                'https://icrrd.com/public/media/15-05-2021-084550The-Alchemist-Paulo-Coelho.pdf',
          ),

          NovelData(
            title: 'The Little Prince',
            description:
                'A timeless story about friendship, love, loss, and seeing the world through a child’s eyes. Its gentle wisdom has comforted generations of readers dealing with loneliness and sadness.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5AEhv609oN3VgN1veswb5-iULlEpBVhElh4VPcpBltw&s',
            bookUrl:
                'https://blogs.ubc.ca/edcp508/files/2016/02/TheLittlePrince.pdf',
          ),

          NovelData(
            title: 'The Midnight Library',
            description:
                'A modern bestseller exploring regret, second chances, and the infinite possibilities of life. Its hopeful message has resonated strongly with readers experiencing sadness and hopelessness.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=800',
            bookUrl:
                'https://www.goodreads.com/book/show/52578297-the-midnight-library',
          ),

          NovelData(
            title: 'Tuesdays with Morrie',
            description:
                'A touching true story about life lessons, love, purpose, and human connection. Many readers find comfort in its reflections on what truly matters in life.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJJiurb3jp9Ik6__VEe-s6plF16R_j4wpWhqWYRvvLlEzgiS549ZZt7xnSzUBhxTCQHO5-_BDBq9wRRnaPFvWlBtK9E2K8ridOskdPkD7t&s=10',
            bookUrl:
                'http://pustaka.unp.ac.id/file/abstrak_kki/EBOOKS/tuesdays%20with%20morrie.pdf',
          ),

          NovelData(
            title: 'Anne of Green Gables',
            description:
                'A charming and uplifting classic filled with imagination, kindness, friendship, and optimism. It remains one of the most comforting novels ever written.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI74css5SSg0eiNzEho-ClgvPMAR1tfkvNsgDkquunivtTyQ5q232t2uE&s=10',
            bookUrl:
                'https://dn720004.ca.archive.org/0/items/anneofgreengable0000lucy_u5q7/anneofgreengable0000lucy_u5q7.pdf',
          ),

          NovelData(
            title: 'The Secret Garden',
            description:
                'A beautiful story about healing, growth, friendship, and renewal. Readers often find its themes of transformation and hope deeply encouraging during difficult periods.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6YBZm_7pNiAfiBEn0sA0GwrHNduYMEXp-DObOFJ33tw&s',
            bookUrl:
                'https://ia601903.us.archive.org/25/items/TheSecretGarden_201303/The%20Secret%20Garden.pdf',
          ),
        ];
      case 'Depressed':
        return [
          NovelData(
            title: 'Man’s Search for Meaning',
            description:
                'Viktor Frankl’s classic memoir explores how people can find purpose even in the most difficult circumstances. It is one of the most frequently recommended books for people struggling with hopelessness, depression, or a loss of meaning in life.',
            thumbnailUrl: 'https://covers.openlibrary.org/b/id/8512577-L.jpg',
            bookUrl:
                'https://antilogicalism.com/wp-content/uploads/2017/07/mans-search-for-meaning.pdf',
          ),

          NovelData(
            title: 'The Yellow Wallpaper',
            description:
                'A powerful short story about mental health, isolation, and recovery. Although written in the 19th century, it remains one of the most discussed literary works related to depression and emotional suffering.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/1952/pg1952.cover.medium.jpg',
            bookUrl:
                'https://www.nlm.nih.gov/exhibition/theliteratureofprescription/exhibitionAssets/digitalDocs/The-Yellow-Wall-Paper.pdf',
          ),

          NovelData(
            title: 'The Prophet',
            description:
                'Kahlil Gibran’s spiritual classic offers reflections on sorrow, joy, love, work, and purpose. Many readers find comfort in its philosophical perspective during difficult emotional periods.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/58585/pg58585.cover.medium.jpg',
            bookUrl:
                'https://www.kahlilgibran.com/images/The%20Prophet%20Ebook%20by%20Kahlil%20Gibran.pdf',
          ),

          NovelData(
            title: 'Siddhartha',
            description:
                'Hermann Hesse’s spiritual novel follows a man searching for peace, wisdom, and meaning. Its themes of self-discovery and personal growth resonate deeply with readers navigating depression and existential struggles.',
            thumbnailUrl: 'https://covers.openlibrary.org/b/id/6562532-M.jpg',
            bookUrl:
                'https://bca.klesnc.edu.in/wp-content/uploads/2025/07/Siddhartha-by-Hermann-Hesse.pdf',
          ),

          NovelData(
            title: 'Letters to a Young Poet',
            description:
                'Rainer Maria Rilke’s collection of letters offers thoughtful advice on loneliness, uncertainty, creativity, and personal growth. Many readers describe it as a comforting companion during difficult times.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/60327/pg60327.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/ebooks/60327',
          ),

          NovelData(
            title: 'The Story of My Life',
            description:
                'Helen Keller’s autobiography is a remarkable story of perseverance, courage, and hope. It inspires readers to keep moving forward despite overwhelming obstacles.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/2397/pg2397.cover.medium.jpg',
            bookUrl:
                'https://cbseacademic.nic.in/web_material/doc/The%20Story%20of%20My%20Life,%20by%20Helen%20Keller.pdf',
          ),
        ];
      case 'Anxious':
        return [
          NovelData(
            title: 'Walden',
            description:
                'Henry David Thoreau’s classic reflection on simple living, mindfulness, and reconnecting with nature. Many anxious readers find comfort in its message of slowing down and focusing on what truly matters.',
            thumbnailUrl:
                'https://www.gutenberg.org/files/205/205-h/images/cover.jpg',
            bookUrl: 'https://www.gutenberg.org/files/205/205-h/205-h.htm',
          ),

          NovelData(
            title: 'The Blue Castle',
            description:
                'A heartwarming novel about a woman trapped by fear and anxiety who gradually learns to embrace life and freedom. Readers often describe it as comforting and uplifting.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/67979/pg67979.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/ebooks/67979',
          ),

          NovelData(
            title: 'The Wisdom of Insecurity',
            description:
                'Alan Watts explores why the search for certainty often creates anxiety. The book encourages readers to embrace the present moment and find peace in uncertainty.',
            thumbnailUrl:
                'https://openlibrary.org/static/images/icons/avatar_book-sm.png',
            bookUrl:
                'https://todaytelemedicine.com/wp-content/uploads/2023/12/The-Wisdom-of-Insecurity-A-Message-for-an-Age-of-Anxiety-Alan-Watts.pdf',
          ),

          NovelData(
            title: 'As a Man Thinketh',
            description:
                'A short classic about the power of thoughts and mindset. Readers struggling with worry often appreciate its practical insights into how thinking patterns influence emotions and behavior.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR0tr7wQE5-QJbkMusCpTPR2-v8DWLhzhVmW8Wr5CLmi92If7ApvEyoXdFlq3Ay5JZI0h4doT1VZaUpZkQbbTRfzdgJd1hVrTtB9Vagdp12A&s=10',
            bookUrl:
                'https://dn790000.ca.archive.org/0/items/asmanthinketh00alleiala/asmanthinketh00alleiala.pdf',
          ),

          NovelData(
            title: 'The Wind in the Willows',
            description:
                'A comforting classic filled with friendship, adventure, and gentle humor. Many readers turn to it as a calming and reassuring escape from stress and anxiety.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/289/pg289.cover.medium.jpg',
            bookUrl:
                'https://web.english.upenn.edu/~cavitch/pdf-library/Grahame_Wind_in_the_Willows_1908.pdf',
          ),
        ];
      case 'Frustrated':
        return [
          NovelData(
            title: 'The Call of the Wild',
            description:
                'Jack London’s classic adventure follows Buck as he faces harsh challenges and constantly adapts to survive. The story inspires resilience, perseverance, and the ability to grow stronger through adversity.',
            thumbnailUrl:
                'https://www.gutenberg.org/files/215/215-h/images/cover.jpg',
            bookUrl: 'https://www.gutenberg.org/files/215/215-h/215-h.htm',
          ),

          NovelData(
            title: 'The Odyssey',
            description:
                'One of the greatest stories of perseverance ever written. Odysseus faces countless setbacks, failures, and obstacles on his journey home, yet never gives up despite overwhelming frustration.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/1727/pg1727.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/ebooks/1727',
          ),

          NovelData(
            title: 'The Count of Monte Cristo',
            description:
                'After suffering betrayal and injustice, Edmond Dantès endures years of hardship before rebuilding his life. The novel demonstrates patience, long-term thinking, and persistence through adversity.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/1184/pg1184.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/ebooks/1184',
          ),

          NovelData(
            title: 'The Little Engine That Could',
            description:
                'A simple but powerful story about determination and self-belief. Its message of “I think I can” continues to inspire readers facing challenges and setbacks.',
            thumbnailUrl:
                'https://archive.org/services/img/TheLittleEngineThatCould',
            bookUrl:
                'https://archive.org/search?query=The+Little+Engine+That+Could',
          ),

          NovelData(
            title: 'Up From Slavery',
            description:
                'Booker T. Washington’s autobiography tells the story of overcoming immense obstacles through persistence, education, and hard work. It remains one of the most inspiring stories of resilience ever written.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/2376/pg2376.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/files/2376/2376-h/2376-h.htm',
          ),

          NovelData(
            title: 'The Story of a Soul',
            description:
                'The autobiography of Saint Thérèse of Lisieux. Through everyday struggles and frustrations, she teaches patience, perseverance, and finding meaning in small acts of progress.',
            thumbnailUrl: 'https://archive.org/services/img/storyofsoul00sain',
            bookUrl: 'https://archive.org/search?query=Story+of+a+Soul+Therese',
          ),
        ];
      case 'Angry':
        return [
          NovelData(
            title: 'The Analects',
            description:
                'Confucius teaches patience, self-discipline, humility, and respectful relationships. Many readers find its wisdom helpful when dealing with anger, resentment, and interpersonal conflicts.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=800',
            bookUrl: 'https://archive.org/details/theanalectsconfucius',
          ),

          NovelData(
            title: 'Uncle Tom’s Cabin',
            description:
                'A moving story that explores injustice, forgiveness, compassion, and moral courage. Despite experiencing cruelty, many characters choose empathy over hatred, making it a meaningful read for angry readers.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/203/pg203.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/files/203/203-h/203-h.htm',
          ),

          NovelData(
            title: 'The Practice of the Presence of God',
            description:
                'Brother Lawrence shares simple reflections on peace, patience, and maintaining calmness in daily life. Readers often turn to this classic when seeking inner tranquility.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/5657/pg5657.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/ebooks/5657',
          ),

          NovelData(
            title: 'Ben-Hur: A Tale of the Christ',
            description:
                'A powerful story of betrayal, suffering, revenge, and ultimately forgiveness. The protagonist’s journey from anger to compassion resonates deeply with readers seeking emotional healing.',
            thumbnailUrl:
                'https://www.gutenberg.org/cache/epub/2145/pg2145.cover.medium.jpg',
            bookUrl: 'https://www.gutenberg.org/ebooks/2145',
          ),

          NovelData(
            title: 'Aesop’s Fables',
            description:
                'These timeless stories teach lessons about temper, impulsiveness, wisdom, and human nature. Many of the fables show the consequences of acting in anger and the value of thoughtful restraint.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/11339',
          ),
        ];
      case 'Hopeless':
        return [
          NovelData(
            title: 'Pollyanna',
            description:
                'A heartwarming classic about a young girl who teaches an entire town to find reasons for gratitude even during hardship. Her famous "Glad Game" helps people discover hope and positivity when life feels overwhelming.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/1450',
          ),

          NovelData(
            title: 'A Little Princess',
            description:
                'Despite losing nearly everything she loves, Sara Crewe refuses to surrender her kindness, imagination, and hope. This inspiring story reminds readers that inner strength can survive even the darkest circumstances.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/146',
          ),

          NovelData(
            title: 'The Wonderful Wizard of Oz',
            description:
                'Dorothy’s journey through an unfamiliar world becomes a powerful story about courage, friendship, and discovering the strengths we already possess. It offers a hopeful reminder that solutions are often closer than they appear.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/55',
          ),

          NovelData(
            title: 'The Railway Children',
            description:
                'A touching story about a family facing sudden hardship and uncertainty. Through love, perseverance, and kindness, they gradually find hope and healing together.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/1874',
          ),

          NovelData(
            title: 'Little Women',
            description:
                'This beloved novel follows four sisters through struggles, disappointments, and personal growth. Its themes of family, resilience, purpose, and hope have comforted readers for generations.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1519682337058-a94d519337bc?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/514',
          ),

          NovelData(
            title: 'Heidi',
            description:
                'A timeless story of healing, friendship, and the restorative power of nature. Heidi’s optimism and kindness bring hope not only to herself but also to those around her.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/20781',
          ),

          NovelData(
            title: 'Pilgrim’s Progress',
            description:
                'One of the most influential stories ever written about perseverance, faith, and continuing forward despite obstacles. It offers encouragement to readers who feel lost or discouraged.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1510936111840-65e151ad71bb?w=800',
            bookUrl: 'https://www.gutenberg.org/ebooks/131',
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
