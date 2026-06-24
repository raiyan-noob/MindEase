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
            title: 'What Depression Feels Like',
            description:
                'A raw and honest vlog by a mental health creator sharing their personal experience living with depression.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=XiCrniLQGYc',
          ),
          VlogData(
            title: 'Free from Social Anxiety',
            description:
                'A heartfelt vlog about the daily struggles of social anxiety and practical steps to overcome it gradually.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=8tRoIgNZ_SU',
          ),
          VlogData(
            title: 'Living with PTSD',
            description:
                'A military veteran shares their emotional journey of living with PTSD and finding hope through community.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1504711434969-e33886168d6c?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=b1BtagDjafI',
          ),
          VlogData(
            title: 'Burnout Is Real',
            description:
                'A personal vlog documenting the signs of burnout and the steps taken to recover and rebuild balance.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1508963493744-76fce69379c0?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=WR03vbN2LOY',
          ),
        ];
      case 'Depressed':
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
            title: 'How Therapy Works',
            description:
                'A mental health professional explains different therapy types like CBT, DBT, and EMDR in simple terms.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=g-i6QMvIAA0',
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
      case 'Anxious':
        return [
          VlogData(
            title: 'My Anxiety Story - Anna',
            description:
                'Anna opens up about her journey with anxiety, panic attacks, and how she found healthy ways to cope.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=WWloIAQpMcQ',
          ),
          VlogData(
            title: 'Free from Social Anxiety',
            description:
                'A heartfelt vlog about the daily struggles of social anxiety and practical steps to overcome it gradually.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=8tRoIgNZ_SU',
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
            title: 'The Power of the Mind',
            description:
                'A powerful documentary exploring the connection between mind, body, and spirit in the healing process.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1532798442725-41036acc7489?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=gJo81_JfsSg',
          ),
        ];
      case 'Frustrated':
        return [
          VlogData(
            title: 'Burnout Is Real',
            description:
                'A personal vlog documenting the signs of burnout and the steps taken to recover and rebuild balance.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1508963493744-76fce69379c0?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=WR03vbN2LOY',
          ),
          VlogData(
            title: 'How Therapy Works',
            description:
                'A mental health professional explains different therapy types like CBT, DBT, and EMDR in simple terms.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=g-i6QMvIAA0',
          ),
          VlogData(
            title: 'The Mind Explained - Netflix',
            description:
                'A fascinating Netflix documentary series exploring anxiety, mindfulness, memory, and how our brains work.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=KNjMq4mS6fQ',
          ),
          VlogData(
            title: 'Day in My Life',
            description:
                'A calming day-in-my-life vlog focused on self-care routines, therapy sessions, and mental health recovery.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=4q1dgn_C0AU',
          ),
        ];
      case 'Angry':
        return [
          VlogData(
            title: 'Living with PTSD',
            description:
                'A military veteran shares their emotional journey of living with PTSD and finding hope through community.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1504711434969-e33886168d6c?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=b1BtagDjafI',
          ),
          VlogData(
            title: 'Burnout Is Real',
            description:
                'A personal vlog documenting the signs of burnout and the steps taken to recover and rebuild balance.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1508963493744-76fce69379c0?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=WR03vbN2LOY',
          ),
          VlogData(
            title: 'The Power of the Mind',
            description:
                'A powerful documentary exploring the connection between mind, body, and spirit in the healing process.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1532798442725-41036acc7489?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=gJo81_JfsSg',
          ),
          VlogData(
            title: 'How Therapy Works',
            description:
                'A mental health professional explains different therapy types like CBT, DBT, and EMDR in simple terms.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=g-i6QMvIAA0',
          ),
        ];
      case 'Hopeless':
        return [
          VlogData(
            title: 'What Makes Us Happy?',
            description:
                'A documentary traveling the world to discover the secrets of happiness from neuroscience to real-life stories.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=krq9GcFaRSA',
          ),
          VlogData(
            title: 'My Year of Living Mindfully',
            description:
                'A filmmaker documents his year-long experiment with daily meditation and its impact on his mental health.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1508672019048-805c876b67e2?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=AqBbXHf_bOc',
          ),
          VlogData(
            title: 'The Power of the Mind',
            description:
                'A powerful documentary exploring the connection between mind, body, and spirit in the healing process.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1532798442725-41036acc7489?w=400&h=300&fit=crop',
            bookUrl: 'https://www.youtube.com/watch?v=gJo81_JfsSg',
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
              child: const Text('Start Healing'),
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
