import 'package:flutter/material.dart';

class BlogData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String bookUrl;

  BlogData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bookUrl,
  });
}

class BlogPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  BlogPage({
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<BlogData> blogs = [
    // Articles & Blogs
    BlogData(
      title: 'Anxiety Disorders',
      description:
          'A guide to understanding different types of anxiety disorders, their symptoms, and coping strategies.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=400&h=300&fit=crop',
      bookUrl:
          'https://www.helpguide.org/articles/anxiety/anxiety-disorders-and-anxiety-attacks.htm',
    ),
    BlogData(
      title: 'The Science of Gratitude',
      description:
          'Discover how practicing gratitude rewires your brain for happiness and improves your overall mental well-being.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=400&h=300&fit=crop',
      bookUrl: 'https://greatergood.berkeley.edu/topic/gratitude',
    ),
    BlogData(
      title: 'Mindfulness for Beginners',
      description:
          'A beginner-friendly blog on how to start practicing mindfulness to reduce stress and live in the present moment.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
      bookUrl:
          'https://www.mindful.org/meditation/mindfulness-getting-started/',
    ),

    BlogData(
      title: 'Sleep and Mental Health',
      description:
          'A Harvard Medical School journal exploring the deep connection between quality sleep and mental health recovery.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=400&h=300&fit=crop',
      bookUrl:
          'https://www.health.harvard.edu/newsletter_article/sleep-and-mental-health',
    ),
    BlogData(
      title: 'Exercise and the Brain',
      description:
          'Research-backed journal on how physical exercise directly impacts brain chemistry, reducing anxiety and depression.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop',
      bookUrl: 'https://www.apa.org/topics/exercise-fitness/stress',
    ),
    BlogData(
      title: 'Media & Mental Health',
      description:
          'An in-depth journal study on the impact of social media usage on mental health, self-esteem, and body image.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?w=400&h=300&fit=crop',
      bookUrl:
          'https://www.mcleanhospital.org/essential/it-or-not-social-medias-affecting-your-mental-health',
    ),

    BlogData(
      title: 'Burnout: Signs and Recovery',
      description:
          'Recognize the early warning signs of burnout and learn effective strategies to recover and prevent it.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1508963493744-76fce69379c0?w=400&h=300&fit=crop',
      bookUrl:
          'https://www.helpguide.org/articles/stress/burnout-prevention-and-recovery.htm',
    ),

    BlogData(
      title: 'Emotional Healing',
      description:
          'Learn how expressive writing and journaling can help process emotions, reduce stress, and boost clarity.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1517842645767-c639042777db?w=400&h=300&fit=crop',
      bookUrl:
          'https://psychcentral.com/health/benefits-of-journaling-for-mental-health',
    ),
    BlogData(
      title: 'Resilience in Tough Times',
      description:
          'Expert advice on developing emotional resilience to bounce back from setbacks and face life\'s challenges.',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1519834785169-98be25ec3f84?w=400&h=300&fit=crop',
      bookUrl: 'https://www.apa.org/topics/resilience/building-your-resilience',
    ),
  ];
  Widget _buildBlogContainer(BlogData blog, Color accent, bool isLight) {
    return Container(
      height: 120,
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
            onTap: () => _launchURL(blog.bookUrl),
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
                    blog.thumbnailUrl,
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
                    blog.title,
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
                  blog.description,
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
                '📝 Articles & Blogs',
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
                ...blogs.map(
                  (blog) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildBlogContainer(blog, accent, isLight),
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
