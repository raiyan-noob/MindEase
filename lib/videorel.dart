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
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Hope Through Remembrance',
            description:
                'Reflective reminders from the Quran and hadith to rebuild hope and inner strength.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Guided Spiritual Breathing',
            description:
                'A breathing exercise paired with gentle spiritual prompts to calm a sad mind.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
        ];
      case 'Depressed':
        return [
          VideoData(
            title: 'Light of Faith Reflection',
            description:
                'Uplifting reflections on Allah’s mercy to help restore purpose and motivation.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1518611505868-48a8f8f22ca3?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Gentle Islamic Affirmations',
            description:
                'Positive affirmations rooted in faith to rebuild self-worth and reduce hopelessness.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Healing Supplication for the Heart',
            description:
                'A short du’a session designed to soothe emotional pain and invite spiritual support.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Slow Spiritual Recitation',
            description:
                'A calming recitation with reflective pauses to gently ease a heavy mind.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
        ];
      case 'Anxious':
        return [
          VideoData(
            title: 'Calming Quranic Breathing',
            description:
                'A guided breathing and Quran reflection practice to reduce anxiety and restore balance.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Mindfulness Through Dhikr',
            description:
                'An anxiety-relief session focused on repeating meaningful names of Allah for calm and clarity.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Stress-Relief Spiritual Talk',
            description:
                'A short lecture on trusting Allah and handling anxious moments with faith.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1518611505868-48a8f8f22ca3?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
        ];
      case 'Frustrated':
        return [
          VideoData(
            title: 'Patience and Sabr',
            description:
                'A thoughtful talk about patience, emotional release, and healing through trust in Allah.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Letting Go With Prayer',
            description:
                'A guided du’a session to calm frustration and encourage gentle self-reflection.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Soothing Spiritual Music',
            description:
                'Music designed to ease irritation and help your heart become more accepting and calm.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
        ];
      case 'Angry':
        return [
          VideoData(
            title: 'Mercy Over Anger',
            description:
                'A powerful reminder of mercy and self-control when anger starts to overwhelm.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Peace After Emotional Turmoil',
            description:
                'A calming lecture focusing on releasing anger and returning to inner peace.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Gentle Du’a for Calm',
            description:
                'A short guided supplication to soften the heart and ease feelings of anger.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1518611505868-48a8f8f22ca3?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
        ];
      case 'Hopeless':
        return [
          VideoData(
            title: 'Finding Hope in Faith',
            description:
                'Uplifting reminders from the Quran that inspire hope and resilience in dark moments.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Stories of Spiritual Renewal',
            description:
                'Realistic reflections on overcoming despair through faith and persistence.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ),
          VideoData(
            title: 'Hope-Filled Recitation',
            description:
                'A gentle Quran recitation meant to bring light and confidence back into your heart.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
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

                  Text(
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
                ],
              ),
            ),
          ],
        ),
      ),
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
