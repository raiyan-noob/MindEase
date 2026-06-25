import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VlogData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String bookUrl;

  VlogData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bookUrl,
  });
}

class VlogPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const VlogPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<VlogPage> createState() => _VlogPageState();
}

class _VlogPageState extends State<VlogPage> with WidgetsBindingObserver {
  late final List<VlogData> vlogs;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    vlogs = _getVlogDataForFeeling(widget.feeling);
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

  List<VlogData> _getVlogDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          VlogData(
            title: 'The Voices of Men',
            description:
                'A powerful mental health documentary featuring real stories from men who struggled with depression, anxiety, and suicidal thoughts. Many viewers describe it as comforting because it reminds them they are not alone in their struggles.',
            thumbnailUrl: 'https://i.ytimg.com/vi/Y0F1cICm9IM/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=Y0F1cICm9IM',
          ),

          VlogData(
            title: 'Fighting Depression',
            description:
                'A short documentary produced by the National Institute of Mental Health that follows the experience of living with depression. It offers hope, understanding, and encouragement for people going through difficult emotional periods.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1493836512294-502baa1986e2?w=800',
            bookUrl:
                'https://www.healthyplace.com/depression-videos/fighting-depression-documentary-video',
          ),

          VlogData(
            title: 'Mentality',
            description:
                'A mental health documentary featuring individuals living with anxiety, depression, bipolar disorder, and other challenges. Viewers often find comfort in hearing honest stories of resilience and recovery.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIXDrm6xpDB-OJLbCKMgx5BnFaNPYLSzyx52fUqlH03g&s=10',
            bookUrl: 'https://youtu.be/Te8DnpcA4-A?si=jTTNuhOfQYH9m2Ue',
          ),

          VlogData(
            title: 'The Journey Through Grief',
            description:
                'A personal, vlog-style short documentary where the creator navigates intense emotional pain. It offers core insights on how letting yourself feel sadness completely, rather than repressing it, is necessary to move past it.',
            thumbnailUrl:
                'https://beyondhealingcounseling.com/wp-content/uploads/2020/09/DSCF0053-2-1024x642.jpeg',
            bookUrl: 'https://youtu.be/_oOpEEe7rVA?si=JE9lPQE1WsVATobo',
          ),

          VlogData(
            title: 'Inside the Teen Mental Health Crisis',
            description:
                'A documentary following teenagers facing depression, loneliness, and emotional struggles. Despite the difficult topics, it ultimately highlights resilience, recovery, and the power of sharing one’s story.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmU5T7l1kywb64T3QGYIlpf7tTxrm40O3sUZSEhJuDALVBx3FXFAB10-51&s=10',
            bookUrl:
                'https://cinemavixion.com/en/watch/inside-the-teen-mental-health-crisis-29018',
          ),

          VlogData(
            title: 'The Secret Life of Lele Pons',
            description:
                'A YouTube documentary series in which Lele Pons openly discusses her struggles with OCD, anxiety, and mental health. Many viewers appreciate its honesty and message that seeking help is a sign of strength.',
            thumbnailUrl:
                'https://i.ytimg.com/vi/eNh898LDiNc/hqdefault.jpg?sqp=-oaymwEgCPYBEIoBSFXyq4qpAxIIARUAAIhCGAFwAcABBrgC9xg=&rs=AOn4CLBeeIJ8yGfXU1xuG947RNmyVmawYg',
            bookUrl:
                'https://youtube.com/playlist?list=PLmjMRs-v1tgRvIN1rqT2x35S2F5QvTW_j&si=8dtT1k-5soPIj4kL',
          ),
        ];
      case 'Depressed':
        return [
          VlogData(
            title: 'How I Held My Breath for 17 Years',
            description:
                'A deeply personal TED Talk by Maggie Freleng about living with depression and emotional pain. Her story resonates with many people who feel trapped in long-term sadness and shows that recovery can begin with vulnerability and self-acceptance.',
            thumbnailUrl:
                'https://img.youtube.com/vi/95ovIJ3dsNk/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=95ovIJ3dsNk',
          ),

          VlogData(
            title: 'Depression, the Secret We Share',
            description:
                'Andrew Solomon’s famous TED Talk explores depression from both a personal and scientific perspective. It is one of the most-viewed talks on depression and has helped countless people feel understood and less alone.',
            thumbnailUrl:
                'https://img.youtube.com/vi/-eBUcBfkVCo/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=-eBUcBfkVCo',
          ),

          VlogData(
            title: 'This Could Be Why You’re Depressed',
            description:
                'Johann Hari investigates surprising causes of depression beyond brain chemistry. The documentary-style talk explores loneliness, purpose, work, and social connection while offering a hopeful message about recovery.',
            thumbnailUrl:
                'https://img.youtube.com/vi/MB5IX-np5fE/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=MB5IX-np5fE',
          ),

          VlogData(
            title: 'Living With Depression',
            description:
                'A documentary produced by Psych Hub featuring real individuals discussing treatment, coping strategies, therapy, and recovery. The focus is practical, educational, and hopeful.',
            thumbnailUrl:
                'https://img.youtube.com/vi/z-IR48Mb3W0/hqdefault.jpg',
            bookUrl:
                'https://ed.ted.com/lessons/what-is-depression-helen-m-farrell',
          ),

          VlogData(
            title: 'How To Get Stuff Done When You Are Depressed',
            description:
                'A highly regarded mental health video that focuses on functioning during depression. It provides realistic advice for rebuilding routines, motivation, and self-care when energy is extremely low.',
            thumbnailUrl:
                'https://img.youtube.com/vi/3QWIxElEnc8/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=3QWIxElEnc8',
          ),

          VlogData(
            title: 'The Science of Depression',
            description:
                'An educational documentary explaining what depression does to the brain, why it affects motivation and emotions, and what treatments have been shown to help people recover.',
            thumbnailUrl:
                'https://img.youtube.com/vi/GOK1Hgm23cU/hqdefault.jpg',
            bookUrl: 'https://youtu.be/IhYueEqyPkM?si=f2YI1FYT89kthBL4',
          ),
        ];
      case 'Anxious':
        return [
          VlogData(
            title: 'How to Cope with Anxiety',
            description:
                'Olivia Remes shares practical and research-backed strategies for managing anxiety in everyday life. Her TED Talk focuses on resilience, mindset shifts, and small actions that can reduce excessive worrying and help people regain a sense of control.',
            thumbnailUrl:
                'https://img.youtube.com/vi/WWloIAQpMcQ/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=WWloIAQpMcQ',
          ),

          VlogData(
            title: 'What Anxiety Feels Like',
            description:
                'A powerful animated TED-Ed video that explains what anxiety feels like from the inside. It helps viewers understand the physical and emotional symptoms of anxiety while reducing feelings of isolation and confusion.',
            thumbnailUrl:
                'https://img.youtube.com/vi/ZidGozDhOjg/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=ZidGozDhOjg',
          ),

          VlogData(
            title: '3 Instantly Calming CBT Techniques for Anxiety',
            description:
                'A practical mental health video teaching evidence-based Cognitive Behavioral Therapy techniques that can quickly reduce anxious thoughts and emotional overwhelm.',
            thumbnailUrl:
                'https://img.youtube.com/vi/o1G4JFuLlO8/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=o1G4JFuLlO8',
          ),

          VlogData(
            title: 'The Anxiety Project Documentary',
            description:
                'A documentary exploring the experiences of people living with anxiety disorders. Through personal stories and expert insights, it highlights both the challenges of anxiety and the paths toward recovery.',
            thumbnailUrl:
                'https://img.youtube.com/vi/jryCoo0BrRk/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=jryCoo0BrRk',
          ),

          VlogData(
            title: 'Guided Meditation for Anxiety',
            description:
                'One of the most popular guided meditation sessions for anxiety relief. It helps viewers slow racing thoughts, regulate breathing, and create a sense of calm during stressful moments.',
            thumbnailUrl:
                'https://img.youtube.com/vi/O-6f5wQXSu8/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=O-6f5wQXSu8',
          ),
        ];
      case 'Frustrated':
        return [
          VlogData(
            title: 'Grit: The Power of Passion and Perseverance',
            description:
                'One of the most influential TED Talks on resilience. Psychologist Angela Duckworth explains why perseverance often matters more than talent when facing obstacles and repeated setbacks. Perfect for people feeling frustrated by slow progress.',
            thumbnailUrl:
                'https://img.youtube.com/vi/H14bBuluwB8/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=H14bBuluwB8',
          ),

          VlogData(
            title: 'The Power of Believing That You Can Improve',
            description:
                'Carol Dweck introduces the growth mindset and explains how viewing challenges as opportunities to learn can transform frustration into motivation. A highly recommended talk for students and professionals alike.',
            thumbnailUrl:
                'https://img.youtube.com/vi/_X0mgOOSpLU/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=_X0mgOOSpLU',
          ),

          VlogData(
            title: 'How to Get Back Up After Failure',
            description:
                'A motivational TED-style talk about recovering from mistakes, disappointments, and setbacks. It emphasizes that failure is not the opposite of success but part of the journey toward it.',
            thumbnailUrl:
                'https://img.youtube.com/vi/RWmChr9NEow/hqdefault.jpg',
            bookUrl: 'https://youtu.be/BQ2_BwqcFsc?si=00HYr9GiYddH-lS9',
          ),

          VlogData(
            title: 'The Mindset of High Achievers',
            description:
                'This documentary explores how successful people deal with rejection, frustration, and repeated failure. It highlights habits that help people keep moving forward when progress feels slow.',
            thumbnailUrl:
                'https://img.youtube.com/vi/TQMbvJNRpLE/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=TQMbvJNRpLE',
          ),

          VlogData(
            title: 'The Struggle You’re In Today',
            description:
                'A powerful motivational film reminding viewers that current frustrations and obstacles can become the foundation for future growth. Frequently shared among people overcoming difficult periods.',
            thumbnailUrl:
                'https://img.youtube.com/vi/mgmVOuLgFB0/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=mgmVOuLgFB0',
          ),

          VlogData(
            title: 'Jiro Dreams of Sushi',
            description:
                'An acclaimed documentary about dedication, mastery, and patience. While not a mental health documentary, many viewers find it inspiring when they feel frustrated by slow progress or imperfect results.',
            thumbnailUrl:
                'https://i.ytimg.com/vi/KAPt5P5nhZw/hq720.jpg?sqp=-oaymwErCNAFEJQDSFryq4qpAx0IARUAAIhCGAHYAQHiAQoIGBACGAY4AUABuAL3GA==&rs=AOn4CLAFz1XcJ7SiJaExJnadiU15iKbZLA',
            bookUrl: 'https://www.cineby.at/movie/80767',
          ),
        ];
      case 'Angry':
        return [
          VlogData(
            title: 'Anger Management | TEDx Talk',
            description:
                'A practical TEDx talk focused on understanding anger as a normal human emotion and learning how empathy, self-awareness, and emotional intelligence can transform destructive anger into constructive action.',
            thumbnailUrl:
                'https://img.youtube.com/vi/ttmHLf1GoIs/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=ttmHLf1GoIs',
          ),

          VlogData(
            title: 'Anger, Compassion, and What It Means To Be Strong',
            description:
                'Psychologist Russell Kolts explains how compassion can be a healthier form of strength than anger. The talk explores why people become angry and how self-compassion can help break cycles of resentment and emotional suffering.',
            thumbnailUrl:
                'https://img.youtube.com/vi/QG4Z185MBJE/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=QG4Z185MBJE',
          ),

          VlogData(
            title: 'Is Venting a Good Way to Deal With Anger?',
            description:
                'A fascinating TEDx talk that challenges the common belief that venting anger is healthy. Through psychology research and real-life examples, it shows why calming techniques often work better than releasing anger explosively.',
            thumbnailUrl:
                'https://img.youtube.com/vi/lyIOCODhx8A/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=lyIOCODhx8A',
          ),

          VlogData(
            title: 'Anger Is Your Ally: A Mindful Approach to Anger',
            description:
                'This TEDx talk explores how mindfulness can change our relationship with anger. Instead of suppressing or exploding, viewers learn how to listen to what anger is trying to communicate and respond wisely.',
            thumbnailUrl:
                'https://img.youtube.com/vi/sbVBsrNnBy8/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=sbVBsrNnBy8',
          ),

          VlogData(
            title: 'The Power of Vulnerability',
            description:
                'Although not specifically about anger, Brené Brown’s famous TED Talk helps many people uncover the hurt, shame, and fear that often exist beneath anger. It encourages emotional openness and healthier relationships.',
            thumbnailUrl:
                'https://img.youtube.com/vi/iCvmsMzlF7o/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=iCvmsMzlF7o',
          ),

          VlogData(
            title: 'How to Control Your Anger',
            description:
                'A practical educational video discussing why anger happens, common triggers, and simple techniques such as breathing exercises, reframing thoughts, and pausing before reacting.',
            thumbnailUrl:
                'https://img.youtube.com/vi/8JdoWslP35I/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=8JdoWslP35I',
          ),

          VlogData(
            title: 'What Your Anger Is Trying to Tell You',
            description:
                'An insightful talk based on psychological research showing that anger often signals unmet needs, perceived injustice, or emotional pain. Understanding those signals can help transform anger into positive change.',
            thumbnailUrl:
                'https://ideas.ted.com/wp-content/uploads/sites/3/2020/05/final_ted-anger-timokuilder-2000.jpg?resize=1000,600',
            bookUrl:
                'https://ideas.ted.com/heres-what-your-anger-is-telling-you-and-how-you-can-talk-back/',
          ),
        ];
      case 'Hopeless':
        return [
          VlogData(
            title: 'The Power of Hope',
            description:
                'This inspiring TEDx Talk explores how hope can transform lives even during adversity. Through powerful stories and psychological research, viewers learn how hope fuels resilience and recovery.',
            thumbnailUrl:
                'https://img.youtube.com/vi/36m1o-tM05g/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=36m1o-tM05g',
          ),

          VlogData(
            title: 'How to Make Meaning When Life Feels Meaningless',
            description:
                'A thought-provoking TED Talk that helps people who feel lost, disconnected, or hopeless. It explores how purpose, relationships, and personal values can help restore direction and motivation.',
            thumbnailUrl:
                'https://img.youtube.com/vi/psaCM1j9LEM/hqdefault.jpg',
            bookUrl: 'https://www.youtube.com/watch?v=psaCM1j9LEM',
          ),

          VlogData(
            title: 'Man’s Search for Meaning',
            description:
                'Based on Viktor Frankl’s influential work, this documentary explores how people can find meaning and purpose even in the most difficult circumstances. Its message has inspired generations facing despair and hopelessness.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://youtu.be/U3qv1fMnV7o?si=_x6yBrRlcMDkWJAk',
          ),

          VlogData(
            title: 'The Science of Hope',
            description:
                'An engaging talk explaining the psychology and neuroscience behind hope. Viewers learn why hope is essential for well-being and how small actions can gradually rebuild it during difficult times.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNDMv4MmA0xiq0O0nAHdnOn1kx9Xusc00gy8Hpe1vm0KfktSCfQu5Yxl0e&s=10',
            bookUrl: 'https://youtu.be/TmJnBonz8qI?si=xkHnXFjKw2Et5RKM',
          ),
        ];
      default:
        return [
          VlogData(
            title: 'What Depression Feels Like',
            description:
                'A raw and honest vlog by a mental health creator sharing their personal experience living with depression.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=XiCrniLQGYc',
          ),
          VlogData(
            title: 'My Anxiety Story - Anna',
            description:
                'Anna opens up about her journey with anxiety, panic attacks, and how she found healthy ways to cope.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=WWloIAQpMcQ',
          ),
          VlogData(
            title: 'Day in My Life',
            description:
                'A calming day-in-my-life vlog focused on self-care routines, therapy sessions, and mental health recovery.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=4q1dgn_C0AU',
          ),
          VlogData(
            title: 'The Mind Explained - Netflix',
            description:
                'A fascinating Netflix documentary series exploring anxiety, mindfulness, memory, and how our brains work.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=KNjMq4mS6fQ',
          ),
        ];
    }
  }

  Widget _buildVlogContainer(VlogData vlog, Color accent, bool isLight) {
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
            onTap: () => _launchURL(vlog.bookUrl),
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
                    vlog.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: accent.withOpacity(0.2),
                        child: Icon(
                          Icons.play_circle_filled_rounded,
                          color: accent,
                          size: 40,
                        ),
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
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 24,
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
                    vlog.title,
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
                    title: vlog.title,
                    description: vlog.description,
                    link: vlog.bookUrl,
                  ),
                  child: Text(
                    vlog.description,
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
                '🎥 Vlogs & Documentaries',
                style: TextStyle(
                  color: isLight
                      ? Color.fromRGBO(16, 100, 56, 1.0)
                      : Color.fromRGBO(184, 220, 193, 1.0),
                  fontFamily: 'Nunito',
                  fontSize: 18,
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
              itemCount: vlogs.length,
              itemBuilder: (context, index) {
                final vlog = vlogs[index];
                return _buildVlogContainer(vlog, accent, isLight);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ),
        );
      },
    );
  }
}
