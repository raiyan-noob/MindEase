import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String bookUrl;
  // true for assets, false for URLs

  BookData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bookUrl,
  });
}

class ReadRelPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const ReadRelPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<ReadRelPage> createState() => _ReadRelPageState();
}

class _ReadRelPageState extends State<ReadRelPage> with WidgetsBindingObserver {
  late final List<BookData> books;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    books = _getBookDataForFeeling(widget.feeling);
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

  List<BookData> _getBookDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          BookData(
            title: 'Thirteen Ways to Calm Our Negative Feelings',
            description:
                'Discover practical techniques used by Buddhist monastics to recognize, calm, and transform difficult emotions such as sadness, loneliness, and emotional overwhelm.',
            thumbnailUrl:
                'https://plumvillage.org/wp-content/uploads/2019/07/plumvillage-black.png',
            bookUrl:
                'https://plumvillage.org/articles/eleven-ways-to-care-for-our-negative-feelings',
          ),

          BookData(
            title: 'Befriend Your Strong Emotions',
            description:
                'Sister Dang Nghiem explains how sadness, regret, insecurity, and self-doubt can be understood and transformed through mindfulness and self-awareness.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM5glYpWTpEPxXuHYG_emYpn_KuA5sYAPGbg&s',
            bookUrl:
                'https://www.sacredcircleholistichealing.com/blog/befriending-our-emotions-the-road-to-self-trust',
          ),

          BookData(
            title: 'Allah’s Formula for Sadness',
            description:
                'An Islamic reflection on coping with grief and sadness through faith, inspired by lessons from the Quran and the stories of the Prophets.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2022/07/748A23EE-77C4-495C-AD8F-759E5ED04E25-300x300.jpeg',
            bookUrl: 'https://aboutislam.net/',
          ),

          BookData(
            title: 'How to Deal with Strong Emotions',
            description:
                'Thich Nhat Hanh teaches that emotions are temporary and can be embraced with mindful breathing and awareness rather than fear or avoidance.',
            thumbnailUrl:
                'https://plumvillage.app/wp-content/uploads/2021/03/still.png',
            bookUrl:
                'https://plumvillage.app/thich-nhat-hanh-on-how-to-deal-with-strong-emotions/',
          ),

          BookData(
            title: 'Finding Hope in Hard Times',
            description:
                'A Christian reflection on finding comfort, resilience, and renewed hope through faith during seasons of sadness, loneliness, and uncertainty.',
            thumbnailUrl:
                'https://i.swncdn.com/media/305w/via/images/2023/10/18/33101/33101-istockgetty-images-pluspeopleimages-62_source_file.webp',
            bookUrl:
                'https://www.crosswalk.com/faith/spiritual-life/finding-hope-in-hard-times.html',
          ),
        ];
      case 'Depressed':
        return [
          BookData(
            title: 'Facts About Depression',
            description:
                'A thoughtful Islamic overview of depression, explaining the difference between sadness and clinical depression. The article discusses emotional struggles, isolation, and how faith can provide comfort while encouraging people to seek help when needed.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2018/06/new.jpg',
            bookUrl:
                'https://aboutislam.net/family-life/your-society/facts-about-depression/',
          ),

          BookData(
            title: 'Dealing with Depression and Anxiety',
            description:
                'This inspiring article explores how believers throughout history have faced grief, anxiety, and emotional pain. It reminds readers that depression is not a sign of weak faith and that there is always a path toward healing and hope.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2017/01/Cure-Depression-1024x682.jpg',
            bookUrl:
                'https://aboutislam.net/reading-islam/living-islam/causes-sadness-depression/',
          ),

          BookData(
            title: '7 Ways to Overcome Depression',
            description:
                'Drawing lessons from the Quran and the lives of the Prophets, this article offers practical spiritual strategies for dealing with depression, sadness, and worry while maintaining hope in Allah.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2019/08/Best-Weapons-Against-Sadness-and-Worry-400x266.jpg',
            bookUrl:
                'https://aboutislam.net/reading-islam/living-islam/what-is-the-remedy-for-sadness/',
          ),

          BookData(
            title: 'A Dua to Say When Depressed and Worried',
            description:
                'A beautiful prophetic supplication for times of anxiety, sorrow, and hopelessness. This short read explains the meaning of the dua and how it can bring peace during emotional struggles.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2017/01/Dua-depression-worries.jpg',
            bookUrl:
                'https://aboutislam.net/reading-islam/about-muhammad/what-to-say-when-depressed-and-worried-one-dua/',
          ),

          BookData(
            title: 'Can Islam Cure Depression?',
            description:
                'An insightful discussion on how Islam addresses depression through faith, balance, worship, community support, and professional treatment when necessary.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2020/02/860_main_depressedteen-300x160.gif',
            bookUrl:
                'https://aboutislam.net/counseling/ask-about-islam/can-islam-cure-depression/',
          ),

          BookData(
            title: 'You Are Both Depression and Mindfulness',
            description:
                'Thich Nhat Hanh explores how mindfulness can help us understand and embrace depression without being consumed by it. A compassionate Buddhist perspective on healing emotional suffering.',
            thumbnailUrl:
                'https://pvappitemimages.b-cdn.net/2TghoQQrNflQEDMFGPvh/thumb@1.5x.jpg',
            bookUrl:
                'https://web.plumvillage.app/item/you-are-both-depression-and-mindfulness',
          ),
        ];
      case 'Anxious':
        return [
          BookData(
            title: 'How to Deal With Anxiety in Islam',
            description:
                'A practical guide to understanding anxiety through an Islamic lens. Learn how prayer, dhikr, patience, and trust in Allah can help calm the heart during times of worry and uncertainty.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/05/What-is-the-Quran-01-667x417.jpg',
            bookUrl:
                'https://aboutislam.net/counseling/ask-the-scholar/morals-manners/how-to-deal-with-anxiety-in-islam/',
          ),

          BookData(
            title: 'What the Quran Says About Anxiety',
            description:
                'Explore Quranic verses and prophetic wisdom that provide comfort during anxious moments. This article highlights spiritual tools for finding peace amidst life’s challenges.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/11/Treasure-Five-Before-Five-400x266.jpg',
            bookUrl:
                'https://aboutislam.net/reading-islam/living-islam/dealing-with-anxiety-in-light-of-quran-sunnah/',
          ),

          BookData(
            title: 'Trusting Allah During Difficult Times',
            description:
                'An inspiring reflection on tawakkul (trust in Allah) and how it can reduce worry about the future. Learn how faith can become a source of strength and reassurance.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/09/hijra-3.jpg',
            bookUrl:
                'https://aboutislam.net/spirituality/trusting-allah-difficult-times/',
          ),

          BookData(
            title: 'How to Handle Strong Emotions',
            description:
                'Thich Nhat Hanh shares mindfulness practices for calming anxious thoughts and reconnecting with the present moment. Learn gentle techniques for finding peace amidst mental turbulence.',
            thumbnailUrl:
                'https://plumvillage.app/wp-content/uploads/2021/03/still.png',
            bookUrl:
                'https://plumvillage.app/thich-nhat-hanh-on-how-to-deal-with-strong-emotions/',
          ),

          BookData(
            title: 'Finding Peace in Times of Anxiety',
            description:
                'A Christian reflection on overcoming anxiety through prayer, trust, and God’s promises. This devotional offers encouragement for those feeling overwhelmed by life’s uncertainties.',
            thumbnailUrl:
                'https://i.swncdn.com/media/305w/via/images/2026/06/17/46568/46568-gettyimages-1500420309_source_file.webp',
            bookUrl:
                'https://www.crosswalk.com/faith/spiritual-life/verses-for-anxiety.html',
          ),
        ];
      case 'Frustrated':
        return [
          BookData(
            title: 'Patience in Times of Hardship',
            description:
                'Life does not always go according to plan, and frustration often arises when our expectations clash with reality. This article explores the Islamic concept of sabr (patience) and how trusting Allah’s wisdom can bring peace during difficult moments.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2019/08/Beyond-Hajj-6-Ways-to-Maintain-Your-Hajj-For-Life-1-400x266.jpg',
            bookUrl: 'https://aboutislam.net/spirituality/patience-in-islam/',
          ),

          BookData(
            title: 'How to Control Anger and Frustration',
            description:
                'Frustration can quickly turn into anger if left unchecked. Drawing from the Quran and Sunnah, this article provides practical techniques for calming the heart, controlling reactions, and responding with wisdom.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2017/10/hijrah-lessons-for-muslim-minorities.jpg',
            bookUrl:
                'https://aboutislam.net/counseling/ask-the-scholar/morals-manners/how-to-control-anger-in-islam/',
          ),

          BookData(
            title: 'Trust Allah’s Plan',
            description:
                'When life feels unfair or progress seems slow, frustration can become overwhelming. This reflection reminds readers that Allah’s timing is perfect and that every challenge carries hidden wisdom and purpose.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/09/hijra-3.jpg',
            bookUrl:
                'https://aboutislam.net/spirituality/trusting-allah-difficult-times/',
          ),

          BookData(
            title: 'When Things Don’t Go Your Way',
            description:
                'A thoughtful Islamic reflection on disappointment, setbacks, and unmet expectations. Discover how faith can help transform frustration into patience, gratitude, and perseverance.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/05/What-is-the-Quran-01.jpg',
            bookUrl:
                'https://aboutislam.net/reading-islam/living-islam/when-things-dont-go-your-way/',
          ),

          BookData(
            title: 'Handling Strong Emotions Mindfully',
            description:
                'Thich Nhat Hanh teaches that frustration is a natural emotion that can be understood and transformed through mindfulness. Learn practical breathing and awareness techniques to calm the mind and regain clarity.',
            thumbnailUrl:
                'https://plumvillage.org/wp-content/uploads/2019/07/plumvillage-black.png',
            bookUrl:
                'https://plumvillage.org/articles/handling-our-strong-emotions',
          ),

          BookData(
            title: 'Finding Strength in Difficult Seasons',
            description:
                'A Christian reflection on dealing with setbacks, discouragement, and frustration through faith. Learn how perseverance, prayer, and trust in God can provide comfort and direction during challenging times.',
            thumbnailUrl:
                'https://i.swncdn.com/media/400w/via/8253-unsplash-joseph-pearson.webp',
            bookUrl:
                'https://www.crosswalk.com/faith/spiritual-life/finding-hope-in-hard-times.html',
          ),
        ];
      case 'Angry':
        return [
          BookData(
            title: 'How to Control Anger and Frustration',
            description:
                'Frustration can quickly turn into anger if left unchecked. Drawing from the Quran and Sunnah, this article provides practical techniques for calming the heart, controlling reactions, and responding with wisdom.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2017/10/hijrah-lessons-for-muslim-minorities.jpg',
            bookUrl:
                'https://aboutislam.net/counseling/ask-the-scholar/morals-manners/how-to-control-anger-in-islam/',
          ),

          BookData(
            title: 'Trust Allah’s Plan',
            description:
                'When life feels unfair or progress seems slow, frustration can become overwhelming. This reflection reminds readers that Allah’s timing is perfect and that every challenge carries hidden wisdom and purpose.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/09/hijra-3.jpg',
            bookUrl:
                'https://aboutislam.net/spirituality/trusting-allah-difficult-times/',
          ),

          BookData(
            title: 'When Things Don’t Go Your Way',
            description:
                'A thoughtful Islamic reflection on disappointment, setbacks, and unmet expectations. Discover how faith can help transform frustration into patience, gratitude, and perseverance.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/05/What-is-the-Quran-01.jpg',
            bookUrl:
                'https://aboutislam.net/reading-islam/living-islam/when-things-dont-go-your-way/',
          ),

          BookData(
            title: 'Finding Peace Through Dhikr',
            description:
                'Dhikr is one of the most powerful remedies for a restless and frustrated heart. Learn how remembrance of Allah can reduce stress, improve emotional resilience, and restore inner tranquility.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2016/09/hijra-3.jpg',
            bookUrl: 'https://aboutislam.net/spirituality/the-power-of-dhikr/',
          ),

          BookData(
            title: 'Handling Strong Emotions Mindfully',
            description:
                'Thich Nhat Hanh teaches that frustration is a natural emotion that can be understood and transformed through mindfulness. Learn practical breathing and awareness techniques to calm the mind and regain clarity.',
            thumbnailUrl:
                'https://plumvillage.org/wp-content/uploads/2019/07/plumvillage-black.png',
            bookUrl:
                'https://plumvillage.org/articles/handling-our-strong-emotions',
          ),

          BookData(
            title: 'Finding Strength in Difficult Seasons',
            description:
                'A Christian reflection on dealing with setbacks, discouragement, and frustration through faith. Learn how perseverance, prayer, and trust in God can provide comfort and direction during challenging times.',
            thumbnailUrl:
                'https://i.swncdn.com/media/400w/via/8253-unsplash-joseph-pearson.webp',
            bookUrl:
                'https://www.crosswalk.com/faith/spiritual-life/finding-hope-in-hard-times.html',
          ),
        ];
      case 'Hopeless':
        return [
          BookData(
            title: 'Hope And Healing',
            description:
                'Mufti Menk reflects on how the stories of the prophets teach hope, resilience, and healing during life’s most difficult moments. A comforting read for anyone struggling with despair or uncertainty.',
            thumbnailUrl:
                'https://aboutislam.net/wp-content/uploads/2025/06/IMG_7938-400x266.jpeg',
            bookUrl:
                'https://aboutislam.net/multimedia/videos/hope-and-healing-mufti-menk/',
          ),

          BookData(
            title: 'Never Lose Hope in the Mercy of Allah',
            description:
                'A reminder that no matter how many mistakes we make or how difficult life becomes, Allah’s mercy is always greater. This article focuses on hope, repentance, and spiritual renewal.',
            thumbnailUrl:
                'https://muslimmatters.org/wp-content/uploads/hope.jpg',
            bookUrl:
                'https://islamio.com/en/watch/new-losing-hope-in-the-mercy-of-allah-mufti-menk/',
          ),

          BookData(
            title: 'Your Way Out of Problems',
            description:
                'An inspiring reflection on trusting Allah during hardship. Learn practical spiritual lessons that help transform anxiety, hopelessness, and confusion into patience and inner peace.',
            thumbnailUrl:
                'https://glasp.co/_next/image?url=https%3A%2F%2Fi.ytimg.com%2Fvi%2FEEAJT3yqKb4%2Fmaxresdefault.jpg&w=1920&q=75',
            bookUrl: 'https://glasp.co/youtube/EEAJT3yqKb4',
          ),

          BookData(
            title: 'Hope in the Mercy of Allah',
            description:
                'This summary explores how maintaining hope in Allah’s mercy can help believers navigate even the darkest periods of life. Filled with examples from prophetic traditions.',
            thumbnailUrl:
                'https://glasp.co/_next/image?url=https%3A%2F%2Fi.ytimg.com%2Fvi%2FyaPe2wpjT3I%2Fmaxresdefault.jpg&w=1920&q=75',
            bookUrl:
                'https://glasp.co/youtube/p/hope-in-the-mercy-of-allah-mufti-menk',
          ),

          BookData(
            title: 'No Mud, No Lotus',
            description:
                'Thich Nhat Hanh explains the Buddhist understanding that suffering and happiness are deeply connected. Learn how pain can become the foundation for growth, wisdom, and compassion.',
            thumbnailUrl:
                'https://plumvillage.org/wp-content/uploads/2019/08/no-mud-no-lotus-768x1143.jpg',
            bookUrl: 'https://plumvillage.org/books/no-mud-no-lotus',
          ),

          BookData(
            title: 'Bhagavad Gita: Finding Purpose in Difficult Times',
            description:
                'Explore timeless Hindu teachings on overcoming despair, confusion, and hopelessness through wisdom, self-discipline, and spiritual understanding.',
            thumbnailUrl:
                'https://www.holy-bhagavad-gita.org/static/global/img/bg_logo_pic.png',
            bookUrl: 'https://www.holy-bhagavad-gita.org/',
          ),

          BookData(
            title: 'Finding Hope Through Faith',
            description:
                'A Christian reflection on trusting God during seasons of pain and uncertainty. Discover messages of comfort, perseverance, and hope from Scripture.',
            thumbnailUrl:
                'https://i.swncdn.com/media/305w/via/8253-unsplash-joseph-pearson.webp',
            bookUrl:
                'https://www.crosswalk.com/faith/spiritual-life/finding-hope-in-hard-times.html',
          ),
        ];
      default:
        return [
          BookData(
            title: 'Default Book',
            description: 'A default book placeholder.',
            thumbnailUrl: 'https://glasp.co/images/og-default.png',
            bookUrl: 'https://glasp.co/youtube/EEAJT3yqKb4',
          ),
        ];
    }
  }

  Widget _buildBookContainer(BookData book, Color accent, bool isLight) {
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
            onTap: () => _launchURL(book.bookUrl),
            child: Container(
              width: 88,
              height: 67,
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
                    book.thumbnailUrl,
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
                    book.title,
                    style: TextStyle(
                      fontSize: 18,
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
                    title: book.title,
                    description: book.description,
                    link: book.bookUrl,
                  ),
                  child: Text(
                    book.description,
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
                '📖 Reading Section',
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
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookContainer(book, accent, isLight);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ),

          /* endDrawer: Drawer(
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
