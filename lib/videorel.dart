import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String videoUrl;
  // true for assets, false for URLs

  VideoData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
  });
}

class VideoRelPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const VideoRelPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<VideoRelPage> createState() => _VideoRelPageState();
}

class _VideoRelPageState extends State<VideoRelPage>
    with WidgetsBindingObserver {
  late final List<VideoData> videos;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    videos = _getVideoDataForFeeling(widget.feeling);
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

  List<VideoData> _getVideoDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          VideoData(
            title: 'Comforting Quran Recitation',
            description:
                'Soothing Quran verses chosen to bring peace and comfort when sadness feels overwhelming.',
            thumbnailUrl:
                'https://cdn.sanity.io/images/2sxb14me/production/38d0b155d3a602383dc7b85d521b730ca198c18f-512x471.jpg',
            videoUrl: 'https://youtu.be/3OZ5C2ON2b0?si=_coSVH1z4ZV2Xz0A',
          ),
          VideoData(
            title: 'Healing Nasheed for the Heart',
            description:
                'A gentle spiritual song that helps release emotional weight and restore calm.',
            thumbnailUrl:
                'https://i.scdn.co/image/ab67616d00001e029f134c5abe0ba0f5b777df24',
            videoUrl: 'https://youtu.be/naWQJpsbPFM?si=oOcg3wUq-NmYx--B',
          ),
          VideoData(
            title: 'Feel to Heal',
            description:
                'A reflective talk about how to connect with your feelings and find healing through faith.',
            thumbnailUrl:
                'https://cdn-images.dzcdn.net/images/cover/2cc7be639552a7084d46f70787106bc0/1900x1900-000000-80-0-0.jpg',
            videoUrl: 'https://youtu.be/Ycn2_QuGe34?si=a4oQbIkrjJ8CIZVC',
          ),
          VideoData(
            title: 'The Quranic remedy for sadness',
            description:
                'A soulsearching lecture by Br. Nouman Ali Khan about how to find solace and healing in the Quran during times of sadness.',
            thumbnailUrl:
                'https://assets.cdn.filesafe.space/vSidPvREeZ6jk189rZX7/media/69e72c342c135a8c83d43349.webp',
            videoUrl: 'https://youtu.be/_3zy5EdKR3g?si=JwVePlg859wm84SJ',
          ),
          VideoData(
            title: 'The Art of Transforming Suffering',
            description:
                'An insightful talk on how to turn pain into spiritual growth and resilience through faith.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnbF-2W5dxJnarcQRSJwRrXxxoLE1FTK6WdnWdXzWsYpS8_2qOcHKQfqoy&s=10',
            videoUrl: 'https://youtu.be/1CnDFr8CJwo?si=VvzV1SHk449q3Hm1',
          ),
          VideoData(
            title: 'How to Handle Your Darkest Seasons',
            description:
                'Sometimes the only way out is through. In this raw and unflinching talk, Dr. Jordan Peterson confronts the one truth most self-help gurus avoid: your darkest season isn’t a detour—it’s the forge where your strongest self is built.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQapxigIwrSC1ss44XR4Z5IqHDIQoAalSI_OCwjYqtvaEE1NV6LfTB0eY8&s=10',
            videoUrl: 'https://youtu.be/Pp8h6-hieLU?si=gHS_XMlK-hAKZorn',
          ),
        ];
      case 'Depressed':
        return [
          VideoData(
            title: 'How to Overcome Anxiety & Depression',
            description:
                'In this powerful Islamic lecture, Yasmin Mogahed addresses one of the most common struggles of our time: anxiety and depression. With wisdom rooted in the Qur’an and Sunnah.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKsfhT29IKrqfb4RyK0e9kpzF_k9QpIMcVzg&s',
            videoUrl: 'https://youtu.be/US3R_z6DMNw?si=mLC5Yekx9RX4m9Se',
          ),
          VideoData(
            title: 'Overcoming Darkness: A Guide To Healing Depression',
            description:
                'A compassionate lecture on understanding depression and finding hope through faith and practical steps.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFIF5sV2iLPzzQS42ur3MBtz4u92vuexN9vQ&s',
            videoUrl: 'https://youtu.be/A5CQAn-Szl4?si=TXGbumcva26INFMe',
          ),
          VideoData(
            title: 'Islam\'s Cure for Depression',
            description:
                'Islam cultivates beliefs and practices in our daily lives that empower us to stay positive and cure the feelings of depression that hold us down.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXSG5NDmdM4gf1I7tPupZVB4UN-kLlharxYA&s',
            videoUrl:
                'https://www.youtube.com/live/0reVZCMYa2w?si=mPtA9ua7gpua5-0n',
          ),
          VideoData(
            title: 'A Sermon on Depression',
            description:
                'Feeling depressed doesn’t mean you lack faith any more than being happy means you have it. Mental illness is not a sin, it’s an illness. It’s time we started talking about it as such.',
            thumbnailUrl:
                'https://cdn.cokesbury.com/images/products/Large/602/9798887691602.jpg',
            videoUrl: 'https://youtu.be/7i4FroQUKYg?si=bihNkSKHzMjMbkEL',
          ),
          VideoData(
            title: 'How To Deal With Depression?',
            description:
                'A lecture on how to deal with depression and anxiety from an Monk\'s perspective.',
            thumbnailUrl:
                'https://web-cdn.meridianuniversity.edu/site-content-images/content-library/mahayana-buddhism-image-two.webp',
            videoUrl: 'https://youtu.be/TEwoWxLwCfA?si=SY7hr4ZzNLfT-NVf',
          ),
        ];
      case 'Anxious':
        return [
          VideoData(
            title: 'Fear & Anxiety | Dealing with Difficulty',
            description:
                'A lecture on how to manage fear and anxiety through faith, reflection, and practical coping strategies.',
            thumbnailUrl:
                'https://i.ytimg.com/vi/ltghXvRvf1E/hqdefault.jpg?v=66041932',
            videoUrl: 'https://youtu.be/ltghXvRvf1E?si=ZtY7a0V0HJjrsGYu',
          ),
          VideoData(
            title: 'Quranic Guidance for Anxiety| Surah Al-Inshirah',
            description:
                'A reflective verses of Quran that provides guidance and comfort for those struggling with anxiety.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAjC1xv-uxDy2erjfkXplWNpe5Iw_0R6A8nw&s',
            videoUrl: 'https://youtu.be/lqJIWX3xMH4?si=cpfOxR9IwExZ3O3J',
          ),
          VideoData(
            title: 'How to Overcome Anxiety & Depression',
            description:
                'In this powerful Islamic lecture, Yasmin Mogahed addresses one of the most common struggles of our time: anxiety and depression. With wisdom rooted in the Qur’an and Sunnah.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKsfhT29IKrqfb4RyK0e9kpzF_k9QpIMcVzg&s',
            videoUrl: 'https://youtu.be/US3R_z6DMNw?si=mLC5Yekx9RX4m9Se',
          ),
          VideoData(
            title: 'Five Ways Faith Can Free You From Anxiety and Depression',
            description:
                'Friends, psychoanalyst Carl Jung said, “At bottom all psychological problems are spiritual problems.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBUyPJZvW1UIHC-WgYjDkqeXAMH6xAuDiL1g&s',
            videoUrl: 'https://youtu.be/uP9v7H7ZWzg?si=-aDVMqrdBBSCyqwA',
          ),
          VideoData(
            title: '4 Ways to Deal with Anxiety | Sadhguru',
            description:
                'Sadhguru explains how to deal with anxiety and stress in a simple and effective way, helping you find inner peace and clarity.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdckuBFuemJu7__gPVIpdi3IuAafxFrzTF2g&s',
            videoUrl: 'https://youtu.be/vO570HeAreI?si=fIPbUNxB3-9gUhBU',
          ),
          VideoData(
            title: 'Meditation for Anxiety and Panic',
            description:
                'Drawing from his own childhood struggles with severe panic attacks, Rinpoche demonstrates how to say "hello" to anxiety and embrace it, rather than fighting it and making it stronger.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBHi7H0IuiUVbZ1BRfK60yeJELCo1i3buMmw&s',
            videoUrl: 'https://youtu.be/n6hsQTFNMic?si=vI68cn6_6JJ50zlE',
          ),
        ];
      case 'Frustrated':
        return [
          VideoData(
            title: 'YOUR FRUSTRATION HAS A PURPOSE || Yasmin Mogahed',
            description:
                'This video directly addresses the frustration of unmet expectations. She explains how to transition your heart from "Why is this happening to me?" to trusting that God’s delays are often a form of protection.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA1T_a7hRQ75fPAXyTY52U_mfvZQ-WB6LzCw&s',
            videoUrl: 'https://youtu.be/tOK5p6Unj24?si=jmziVtF1lILPk-iN',
          ),
          VideoData(
            title: 'Frustrating Situations | Dealing with Difficulty',
            description:
                'A highly practical, comforting talk about dealing with everyday frustrations caused by people or failed plans. He provides direct steps from the Prophetic tradition, such as changing your physical posture and seeking refuge when you feel your blood boiling.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj2qZBTKgC1Iv2i_nTIB3w58t8locbhgJQnA&s',
            videoUrl: 'https://youtu.be/4SNaVzg71bE?si=Mah-Uh0S8DYPu6nu',
          ),
          VideoData(
            title: 'Reacting vs Responding',
            description:
                'Using a mix of humor and deep wisdom, this monk explains that frustration comes from trying to control things outside our circle of influence. He shares a famous mental framework to help you stop worrying about outcomes you cannot change',
            thumbnailUrl:
                'https://cdn.penguin.co.in/wp-content/uploads/2022/09/9789354928093-1-scaled.jpg',
            videoUrl: 'https://youtu.be/fpi0KuJhz2A?si=8FLpDzst3Wf0O9rI',
          ),
          VideoData(
            title: 'What to Do When You Are Hurting | Joyce Meyer',
            description:
                'Joyce Meyer delivers a raw, highly relatable sermon on how frustration is a sign that we are trying to force our own will instead of trusting God. She gives practical advice on how to physically and mentally step back and "let God work."',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_lLiEOc-RrhF8jhrIpTXE-eNyU0l_wtFy5A&s',
            videoUrl: 'https://youtu.be/KW1F8AZESBI?si=r0Llndab4qEGKkMb',
          ),
          VideoData(
            title: 'Transforming Frustration Into Peace',
            description:
                'A deeply gentle teaching on how to handle the "energy of frustration." Instead of acting out or suppressing your annoyance, the Zen Master teaches you how to use mindful breathing to calm your mind and look at the situation with deep insight.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_lr_0YKmihdY8rki5MyHe4XSKCwQuHdooxg&s',
            videoUrl: 'https://youtu.be/lknQHg6pqWQ?si=ZZA7MWIFUMrSXT13',
          ),
        ];
      case 'Angry':
        return [
          VideoData(
            title: 'Taking Care of Anger',
            description:
                'Thich Nhat Hanh explains how anger often grows from unaddressed suffering and misunderstanding. Through mindful breathing and self-awareness, this talk teaches practical ways to calm intense emotions and transform anger into compassion.',
            thumbnailUrl:
                'https://img.youtube.com/vi/9OvLOna5_1A/maxresdefault.jpg',
            videoUrl: 'https://www.youtube.com/watch?v=9OvLOna5_1A',
          ),

          VideoData(
            title: 'How to Let Anger Out?',
            description:
                'A thoughtful discussion on dealing with anger without suppressing or expressing it destructively. Learn how mindfulness can help you understand the root causes of your emotions and respond with wisdom instead of reaction.',
            thumbnailUrl:
                'https://img.youtube.com/vi/WTF9xgqLIvI/maxresdefault.jpg',
            videoUrl: 'https://www.youtube.com/watch?v=WTF9xgqLIvI',
          ),

          VideoData(
            title: 'Controlling Anger',
            description:
                'This session offers practical mindfulness exercises that can be used during moments of frustration and irritation. It focuses on developing patience, emotional awareness, and inner peace in everyday life.',
            thumbnailUrl:
                'https://i.ytimg.com/vi/PdM5sCzld5o/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDULOEPhvE6-HUqxCVQ8Q7VjOdglg',
            videoUrl: 'https://youtu.be/znYFlGgK3vs?si=_YbUGeVcbqSf-wmK',
          ),

          VideoData(
            title: 'Dealing With Anger',
            description:
                'Drawing from the Quran and Sunnah, this talk provides guidance on controlling anger before it controls you. Learn effective spiritual practices that encourage patience, mercy, and self-restraint during difficult situations.',
            thumbnailUrl:
                'https://img.youtube.com/vi/5pyZkY93B2A/maxresdefault.jpg',
            videoUrl: 'https://www.youtube.com/watch?v=5pyZkY93B2A',
          ),
          VideoData(
            title: 'Healing the Heart',
            description:
                'Yasmin Mogahed discusses how emotional wounds, disappointments, and unmet expectations often fuel anger. Discover faith-based perspectives on healing, acceptance, and finding tranquility through trust in Allah.',
            thumbnailUrl:
                'https://img.youtube.com/vi/mlk70CGw5g4/maxresdefault.jpg',
            videoUrl: 'https://www.youtube.com/watch?v=mlk70CGw5g4',
          ),
          VideoData(
            title: 'Anger Management-FULL SERMON | Joyce Meyer',
            description:
                'An insightful sermon on understanding the nature of anger, its impact on our lives, and how to manage it effectively through spiritual and practical approaches.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK4a6DMoEKGM6ObGcFO2wXz3YRWA6WBNbchg&s',
            videoUrl: 'https://youtu.be/QWyowstWWhI?si=6zDnU5mrTUhaw32t',
          ),
        ];
      case 'Hopeless':
        return [
          VideoData(
            title: 'Hope in the Mercy of Allah - Mufti Menk',
            description:
                'A powerful reminder that no matter how difficult life becomes, Allah’s mercy is always greater. This talk encourages patience, trust, and hope during periods of sadness, failure, and uncertainty.',
            thumbnailUrl:
                'https://glasp.co/_next/image?url=https%3A%2F%2Fi.ytimg.com%2Fvi%2FyaPe2wpjT3I%2Fmaxresdefault.jpg&w=1920&q=75',
            videoUrl: 'https://youtu.be/yaPe2wpjT3I?si=Wuu3rgf2_SobLeTn',
          ),
          VideoData(
            title: 'From Despair to Hope',
            description:
                'Learn how faith, gratitude, and reliance on Allah can help transform feelings of hopelessness into optimism. This lecture offers practical spiritual guidance for overcoming despair.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVySY4xQ9QqHlp9DKE0cDemwIk0FkcWDOdaQ&s',
            videoUrl: 'https://youtu.be/-RS6SGsHVl4?si=ktNRwCcYyrCNjOHP',
          ),
          VideoData(
            title: 'Healing the Heart',
            description:
                'Yasmin Mogahed discusses how emotional wounds, disappointments, and unmet expectations often fuel anger. Discover faith-based perspectives on healing, acceptance, and finding tranquility through trust in Allah.',
            thumbnailUrl:
                'https://img.youtube.com/vi/mlk70CGw5g4/maxresdefault.jpg',
            videoUrl: 'https://www.youtube.com/watch?v=mlk70CGw5g4',
          ),
          VideoData(
            title: 'No Mud No Lotus',
            description:
                'Thich Nhat Hanh explains how suffering can become the foundation for growth, healing, and happiness. This teaching offers hope to those struggling with despair by showing how pain can be transformed into wisdom and compassion.',
            thumbnailUrl:
                'https://img.youtube.com/vi/stiG6IzDITc/maxresdefault.jpg',
            videoUrl: 'https://www.youtube.com/watch?v=stiG6IzDITc',
          ),
          VideoData(
            title: 'God Has Not Forgotten You',
            description:
                'An uplifting Christian message for anyone feeling lost, discouraged, or abandoned. This sermon reminds viewers that hope, strength, and purpose can be found through faith in God.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7JGBsTiT12QoaUq1z3TCBaFQUkhG-tmSeOw&s',
            videoUrl: 'https://youtu.be/Cy0V5Omwpyc?si=0-nBhu9LGJrAn6PO',
          ),
        ];
      default:
        return [
          VideoData(
            title: 'Spiritual Healing Essentials',
            description:
                'A selection of healing videos combining recitation, reflection, and calming music.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Reflection and Renewal',
            description:
                'A faith-based reminder to reset your mind and reconnect with what matters most.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
        ];
    }
  }

  Widget _buildVideoContainer(VideoData video, Color accent, bool isLight) {
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
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _launchURL(video.videoUrl),
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
                      video.thumbnailUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: accent.withOpacity(0.2),
                          child: Icon(
                            Icons.play_circle,
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
                        Icons.play_arrow,
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
                      video.title,
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
                      title: video.title,
                      description: video.description,
                      link: video.videoUrl,
                    ),
                    child: Text(
                      video.description,
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
                '▶ Watch or Listen',
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
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return _buildVideoContainer(video, accent, isLight);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ),
        );
      },
    );
  }
}
