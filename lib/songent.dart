import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SongData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String bookUrl;
  // true for assets, false for URLs

  SongData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bookUrl,
  });
}

class SongEntPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const SongEntPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<SongEntPage> createState() => _SongEntPageState();
}

class _SongEntPageState extends State<SongEntPage> with WidgetsBindingObserver {
  late final List<SongData> songs;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    songs = _getSongDataForFeeling(widget.feeling);
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

  List<SongData> _getSongDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          SongData(
            title: 'Happy',
            description:
                'One of the most famous feel-good songs ever made. Its upbeat rhythm and positive energy have helped millions of listeners lift their mood and focus on joy rather than sadness.',
            thumbnailUrl:
                'https://img.youtube.com/vi/ZbZSe6N_BXs/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=ZbZSe6N_BXs',
          ),

          SongData(
            title: 'Don\'t Worry, Be Happy',
            description:
                'A timeless classic that encourages listeners to let go of worries and embrace a lighter perspective on life. Simple, cheerful, and surprisingly effective when feeling down.',
            thumbnailUrl:
                'https://img.youtube.com/vi/d-diB65scQU/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=d-diB65scQU',
          ),

          SongData(
            title: 'Walking On Sunshine',
            description:
                'An energetic song that instantly brings warmth and positivity. Frequently recommended in happiness playlists because of its infectious optimism and uplifting vibe.',
            thumbnailUrl:
                'https://img.youtube.com/vi/iPUmE-tne5U/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=iPUmE-tne5U',
          ),

          SongData(
            title: 'Mr. Blue Sky',
            description:
                'A cheerful classic filled with bright melodies and hopeful energy. Many listeners describe it as one of the easiest songs to smile to, even during difficult days.',
            thumbnailUrl:
                'https://img.youtube.com/vi/wuJIqmha2Hk/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=wuJIqmha2Hk',
          ),

          SongData(
            title: 'Firework',
            description:
                'A motivational anthem about recognizing your worth and shining despite challenges. Its message of self-belief can be especially comforting during periods of sadness.',
            thumbnailUrl:
                'https://img.youtube.com/vi/QGJuMBdaqIw/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=QGJuMBdaqIw',
          ),

          SongData(
            title: 'Good Time',
            description:
                'A lighthearted song about enjoying the present moment and letting go of stress. Perfect for creating a more positive and carefree mindset.',
            thumbnailUrl:
                'https://img.youtube.com/vi/H7HmzwI67ec/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=H7HmzwI67ec',
          ),

          SongData(
            title: 'Beautiful Day',
            description:
                'A powerful reminder that even during difficult moments there is still beauty and hope to be found. Its uplifting message has resonated with listeners for decades.',
            thumbnailUrl:
                'https://img.youtube.com/vi/co6WMzDOh1o/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=co6WMzDOh1o',
          ),
        ];
      case 'Depressed':
        return [
          SongData(
            title: 'Fight Song',
            description:
                'An empowering anthem about finding strength when life feels overwhelming. Many listeners turn to this song during difficult periods because of its message that even a small spark of hope can make a difference.',
            thumbnailUrl:
                'https://img.youtube.com/vi/xo1VInw-SKc/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=xo1VInw-SKc',
          ),

          SongData(
            title: 'Hall of Fame',
            description:
                'A motivational song that encourages listeners to believe in themselves and keep moving forward despite setbacks. Its uplifting lyrics remind people that their struggles do not define their future.',
            thumbnailUrl:
                'https://img.youtube.com/vi/mk48xRzuNvA/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=mk48xRzuNvA',
          ),

          SongData(
            title: 'Rise Up',
            description:
                'A deeply emotional song about resilience, healing, and standing up again after being knocked down by life. It has become a source of comfort and inspiration for many people facing emotional struggles.',
            thumbnailUrl:
                'https://img.youtube.com/vi/kNKu1uNBVkU/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=kNKu1uNBVkU',
          ),

          SongData(
            title: 'Unstoppable',
            description:
                'A powerful reminder of inner strength and perseverance. The song encourages listeners to believe that they are stronger than their fears, doubts, and difficult circumstances.',
            thumbnailUrl:
                'https://img.youtube.com/vi/YaEG2aWJnZ8/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=YaEG2aWJnZ8',
          ),

          SongData(
            title: 'Stronger (What Doesn\'t Kill You)',
            description:
                'A motivational anthem about growing through adversity. Its energetic message encourages people to see challenges as opportunities to become stronger and more resilient.',
            thumbnailUrl:
                'https://img.youtube.com/vi/Xn676-fLq7I/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=Xn676-fLq7I',
          ),

          SongData(
            title: 'Count on Me',
            description:
                'A warm and reassuring song about friendship, support, and never facing struggles alone. It reminds listeners that there are always people who care about them.',
            thumbnailUrl:
                'https://img.youtube.com/vi/6k8cpUkKK4c/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=6k8cpUkKK4c',
          ),

          SongData(
            title: 'Here Comes the Sun',
            description:
                'A timeless classic about hope returning after a long period of darkness. Its gentle melody and optimistic message have comforted listeners for generations.',
            thumbnailUrl:
                'https://img.youtube.com/vi/KQetemT1sWc/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=KQetemT1sWc',
          ),
        ];
      case 'Anxious':
        return [
          SongData(
            title: 'Weightless',
            description:
                'Often cited as one of the most relaxing pieces of music ever created. Its slow tempo, ambient sounds, and soothing progression have helped many listeners reduce feelings of stress, anxiety, and mental overwhelm.',
            thumbnailUrl:
                'https://img.youtube.com/vi/UfcAVejslrU/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=UfcAVejslrU',
          ),

          SongData(
            title: 'River Flows in You',
            description:
                'A beautiful piano composition that creates a sense of calm and emotional balance. Many people listen to it while studying, meditating, or trying to quiet anxious thoughts.',
            thumbnailUrl:
                'https://img.youtube.com/vi/7maJOI3QMu0/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=7maJOI3QMu0',
          ),

          SongData(
            title: 'Clair de Lune',
            description:
                'One of the most beloved classical piano pieces ever written. Its gentle and dreamy melody can help slow racing thoughts and create a peaceful mental space.',
            thumbnailUrl:
                'https://img.youtube.com/vi/CvFH_6DNRCY/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=CvFH_6DNRCY',
          ),

          SongData(
            title: 'Three Little Birds',
            description:
                'Bob Marley’s iconic message of “every little thing is gonna be alright” has comforted generations of listeners facing worry, uncertainty, and anxiety.',
            thumbnailUrl:
                'https://img.youtube.com/vi/HNBCVM4KbUM/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=HNBCVM4KbUM',
          ),
          SongData(
            title: 'Pure Shores',
            description:
                'A relaxing and atmospheric song that creates a feeling of escape from everyday stress. Its soothing soundscape makes it popular among people seeking calm and clarity.',
            thumbnailUrl:
                'https://img.youtube.com/vi/dVNdTXEJv1A/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=dVNdTXEJv1A',
          ),

          SongData(
            title: 'Breathe Me',
            description:
                'A deeply emotional and reflective song that helps listeners feel understood during moments of vulnerability. Many people find comfort in its honesty and gentle delivery.',
            thumbnailUrl:
                'https://img.youtube.com/vi/PwB56IYDfWs/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=PwB56IYDfWs',
          ),
        ];
      case 'Frustrated':
        return [
          SongData(
            title: 'Eye of the Tiger',
            description:
                'One of the most iconic motivational songs ever created. Its driving rhythm and determined energy help transform frustration into focus, perseverance, and action.',
            thumbnailUrl:
                'https://img.youtube.com/vi/btPJPFnesV4/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=btPJPFnesV4',
          ),

          SongData(
            title: 'Hall of Fame',
            description:
                'A powerful anthem about pushing through obstacles and believing in your potential. Perfect for moments when frustration is making you doubt yourself or your abilities.',
            thumbnailUrl:
                'https://img.youtube.com/vi/mk48xRzuNvA/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=mk48xRzuNvA',
          ),

          SongData(
            title: 'Stronger (What Doesn\'t Kill You)',
            description:
                'An uplifting reminder that challenges can make us more resilient. The song encourages listeners to view setbacks as opportunities for growth rather than reasons to give up.',
            thumbnailUrl:
                'https://img.youtube.com/vi/Xn676-fLq7I/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=Xn676-fLq7I',
          ),

          SongData(
            title: 'Unstoppable',
            description:
                'A confidence-boosting anthem that inspires listeners to keep moving forward despite obstacles. Its empowering lyrics make it a favorite during moments of self-doubt and frustration.',
            thumbnailUrl:
                'https://img.youtube.com/vi/YaEG2aWJnZ8/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=YaEG2aWJnZ8',
          ),

          SongData(
            title: 'Believer',
            description:
                'A high-energy song about transforming pain and frustration into strength. Many listeners find its message empowering when dealing with setbacks or difficult circumstances.',
            thumbnailUrl:
                'https://img.youtube.com/vi/7wtfhZwyrcc/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=7wtfhZwyrcc',
          ),

          SongData(
            title: 'Lose Yourself',
            description:
                'A legendary motivational track about seizing opportunities and overcoming fear. Its intense focus and determination can help redirect frustration into productive action.',
            thumbnailUrl:
                'https://img.youtube.com/vi/_Yhyp-_hX2s/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=_Yhyp-_hX2s',
          ),

          SongData(
            title: 'On Top of the World',
            description:
                'An upbeat and optimistic song that encourages listeners to celebrate progress and keep moving forward. Great for shifting from frustration to a more positive mindset.',
            thumbnailUrl:
                'https://img.youtube.com/vi/w5tWYmIOWGk/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=w5tWYmIOWGk',
          ),
        ];
      case 'Angry':
        return [
          SongData(
            title: 'Let It Be',
            description:
                'A timeless classic about acceptance, wisdom, and finding peace during difficult moments. Its gentle message encourages listeners to step back from intense emotions and trust that clarity will come with time.',
            thumbnailUrl:
                'https://img.youtube.com/vi/QDYfEBY9NM4/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=QDYfEBY9NM4',
          ),

          SongData(
            title: 'Three Little Birds',
            description:
                'Bob Marley’s reassuring message that “every little thing is gonna be alright” has helped generations of listeners reduce stress, anger, and frustration. A simple but powerful reminder to let go of what cannot be controlled.',
            thumbnailUrl:
                'https://img.youtube.com/vi/HNBCVM4KbUM/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=HNBCVM4KbUM',
          ),

          SongData(
            title: 'Here Comes the Sun',
            description:
                'A warm and hopeful song about moving through dark periods and welcoming brighter days. Its uplifting melody can help soften feelings of anger and replace them with optimism.',
            thumbnailUrl:
                'https://img.youtube.com/vi/KQetemT1sWc/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=KQetemT1sWc',
          ),

          SongData(
            title: 'River Flows in You',
            description:
                'A calming piano composition that helps slow racing thoughts and emotional intensity. Many listeners use it as a way to decompress after stressful or frustrating experiences.',
            thumbnailUrl:
                'https://img.youtube.com/vi/7maJOI3QMu0/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=7maJOI3QMu0',
          ),

          SongData(
            title: 'Weightless',
            description:
                'Created specifically to promote relaxation, this ambient track is widely known for helping listeners reduce stress and emotional tension. Ideal for cooling down when anger feels overwhelming.',
            thumbnailUrl:
                'https://img.youtube.com/vi/UfcAVejslrU/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=UfcAVejslrU',
          ),

          SongData(
            title: 'Fix You',
            description:
                'A heartfelt song about healing, support, and emotional recovery. Its comforting lyrics and gradual build-up encourage listeners to process difficult emotions with compassion rather than resentment.',
            thumbnailUrl:
                'https://img.youtube.com/vi/k4V3Mo61fJM/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=k4V3Mo61fJM',
          ),
        ];
      case 'Hopeless':
        return [
          SongData(
            title: 'Rise Up',
            description:
                'A powerful anthem about standing back up after life knocks you down. Its message of resilience, courage, and perseverance has inspired countless listeners facing hardship and hopelessness.',
            thumbnailUrl:
                'https://img.youtube.com/vi/kNKu1uNBVkU/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=kNKu1uNBVkU',
          ),

          SongData(
            title: 'You Raise Me Up',
            description:
                'A deeply uplifting song about finding strength through support, faith, and human connection. Many listeners turn to it during difficult times as a reminder that they do not have to carry their burdens alone.',
            thumbnailUrl:
                'https://img.youtube.com/vi/aJxrX42WcjQ/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=aJxrX42WcjQ',
          ),

          SongData(
            title: 'Carry On',
            description:
                'A hopeful reminder that even after setbacks, heartbreak, or failure, life continues. Its encouraging lyrics help listeners find the strength to keep moving forward one step at a time.',
            thumbnailUrl:
                'https://img.youtube.com/vi/q7yCLn-O-Y0/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=q7yCLn-O-Y0',
          ),

          SongData(
            title: 'Fix You',
            description:
                'One of the most comforting songs ever written about pain, healing, and emotional recovery. Its message reassures listeners that brokenness is not permanent and that healing is possible.',
            thumbnailUrl:
                'https://img.youtube.com/vi/k4V3Mo61fJM/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=k4V3Mo61fJM',
          ),

          SongData(
            title: 'Here Comes the Sun',
            description:
                'A timeless classic about hope returning after a long period of darkness. Its gentle optimism reminds listeners that difficult seasons eventually pass and brighter days can come again.',
            thumbnailUrl:
                'https://img.youtube.com/vi/KQetemT1sWc/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=KQetemT1sWc',
          ),

          SongData(
            title: 'Brave',
            description:
                'An encouraging song about finding your voice, taking small steps forward, and refusing to let fear define your future. Its uplifting message can help restore confidence and hope.',
            thumbnailUrl:
                'https://img.youtube.com/vi/QUQsqBqxoR4/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=QUQsqBqxoR4',
          ),

          SongData(
            title: 'Somewhere Over the Rainbow',
            description:
                'A soothing and hopeful song that paints a picture of better days ahead. Its calming melody and optimistic message have comforted listeners for generations.',
            thumbnailUrl:
                'https://img.youtube.com/vi/V1bFr2SWP1I/maxresdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=V1bFr2SWP1I',
          ),
        ];
      default:
        return [
          SongData(
            title: 'Default Song',
            description: 'A default song placeholder.',
            thumbnailUrl: 'https://glasp.co/images/og-default.png',
            bookUrl: 'https://glasp.co/youtube/EEAJT3yqKb4',
          ),
        ];
    }
  }

  Widget _buildSongContainer(SongData song, Color accent, bool isLight) {
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
            onTap: () => _launchURL(song.bookUrl),
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
                    song.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: accent.withOpacity(0.2),
                        child: Icon(Icons.music_note, color: accent, size: 40),
                      );
                    },
                  ),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 26,
                    ),
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
                    song.title,
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
                    title: song.title,
                    description: song.description,
                    link: song.bookUrl,
                  ),
                  child: Text(
                    song.description,
                    style: TextStyle(
                      fontSize: 13,
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
                '🎵 Music & Songs',
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
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return _buildSongContainer(song, accent, isLight);
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
