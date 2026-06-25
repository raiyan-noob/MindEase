import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  const BlogPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> with WidgetsBindingObserver {
  late final List<BlogData> blogs;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    blogs = _getBlogDataForFeeling(widget.feeling);
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

  List<BlogData> _getBlogDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          BlogData(
            title: 'How to Cope with Sadness',
            description:
                'A practical guide written by mental health professionals that helps readers understand sadness, identify its causes, and develop healthy coping strategies. The article emphasizes self-compassion and emotional processing rather than suppressing difficult feelings.',
            thumbnailUrl:
                'https://images.squarespace-cdn.com/content/v1/656f4e4dababbd7c042c4946/0760e947-13c2-4131-953f-d6b85ca59712/how+to+stop+feeling+sad-3x2.jpg?format=2500w',
            bookUrl: 'https://www.talkspace.com/blog/how-to-deal-with-sadness/',
          ),

          BlogData(
            title: 'How to Stop Feeling Sad: 7 Tips to Boost Your Mood',
            description:
                'A thoughtful article that explains why sadness is a normal part of life and provides practical, evidence-informed ways to navigate it. Readers learn mindfulness techniques, connection strategies, and small habits that can gradually improve emotional well-being.',
            thumbnailUrl:
                'https://cdn.prod.website-files.com/643420fa9df2945c7d77af2d/690a7294a276cf35fb2ca835_690a72931e790b1973aadf3f_how-to-deal-with-sadness-featured.jpeg',
            bookUrl: 'https://www.calm.com/blog/how-to-stop-feeling-sad',
          ),

          BlogData(
            title: 'On Sadness: How to Accept, Grieve, and Reclaim Your Energy',
            description:
                'A therapist-guided reflection on understanding sadness without fighting it. The article encourages readers to accept difficult emotions, process grief in a healthy way, and gradually move toward healing and renewed energy.',
            thumbnailUrl:
                'https://cdn.prod.website-files.com/6668b6628314b015b39991b8/689c8258f9756bbe3eabcf83_blog-emotions-sad-edge.svg',
            bookUrl: 'https://www.getstoic.com/blog/on-sadness',
          ),

          BlogData(
            title:
                'Grief Meditation: How to Use Mindfulness to Heal After Loss',
            description:
                'This Calm article explores how mindfulness can help people navigate grief, sadness, and emotional pain. It offers practical meditation techniques and compassionate guidance for healing after loss.',
            thumbnailUrl:
                'https://images.squarespace-cdn.com/content/v1/656f4e4dababbd7c042c4946/dd9b08f6-4f37-483f-8045-dde267eae760/grief-meditation?format=2500w',
            bookUrl: 'https://www.calm.com/blog/grief-meditation',
          ),
          BlogData(
            title:
                'Meditation for Healing: 14 Practices for Emotional Recovery',
            description:
                'A collection of guided mindfulness approaches designed to support emotional healing, resilience, and recovery from sadness, grief, and emotional exhaustion.',
            thumbnailUrl:
                'https://images.squarespace-cdn.com/content/v1/656f4e4dababbd7c042c4946/63582d6d-815f-4560-b9e0-f1f2d2a5afcf/meditation+for+healing-3x2.jpg?format=2500w',
            bookUrl: 'https://www.calm.com/blog/meditation-for-healing',
          ),
        ];
      case 'Depressed':
        return [
          BlogData(
            title: 'What Depression Really Feels Like',
            description:
                'A compassionate article that helps readers understand depression beyond ordinary sadness. It explores common experiences such as emotional numbness, hopelessness, exhaustion, and self-doubt while reminding readers that recovery is possible.',
            thumbnailUrl:
                'https://media.post.rvohealth.io/wp-content/uploads/2022/11/sports-fans-732x549-thumbnail.jpg',
            bookUrl: 'https://www.healthline.com/health/depression',
          ),

          BlogData(
            title: 'Self-Compassion and Depression',
            description:
                'Many people struggling with depression become trapped in cycles of self-criticism. This article explains how self-compassion can reduce emotional suffering and help create a healthier relationship with oneself.',
            thumbnailUrl:
                'https://self-compassion.org/wp-content/uploads/self-compassion.jpg',
            bookUrl:
                'https://self-compassion.org/self-compassion-and-depression/',
          ),

          BlogData(
            title: 'How Mindfulness Helps Depression',
            description:
                'This article explains how mindfulness practices can help reduce rumination, improve emotional awareness, and create space between negative thoughts and personal identity.',
            thumbnailUrl:
                'https://www.mindful.org/content/uploads/juliane-liebermann-O-RKu3Aqnsw-unsplash-2048x1365.jpg',
            bookUrl:
                'https://www.mindful.org/how-mindfulness-can-help-with-depression/',
          ),

          BlogData(
            title: 'The Importance of Human Connection',
            description:
                'Depression often causes people to withdraw from others. This article explores why meaningful relationships are essential for emotional well-being and how small social connections can support recovery.',
            thumbnailUrl:
                'https://ggsc.s3.us-west-2.amazonaws.com/assets/images/6_18_26_soh_wowsabout_awe_-_abcdef_-_0f7fa3008cfea6a8d775697c0e41c13efd958423.webp',
            bookUrl:
                'https://greatergood.berkeley.edu/article/item/why_social_connection_is_important',
          ),

          BlogData(
            title: 'Emotional Exhaustion: When Your Feelings Feel Overwhelming',
            description:
                'A practical guide from mental health professionals explaining emotional exhaustion, hopelessness, lack of motivation, and burnout. The article provides actionable strategies for regaining emotional balance, managing stress, and taking small steps toward recovery.',
            thumbnailUrl:
                'https://www.mayoclinichealthsystem.org/-/media/national-files/images/hometown-health/2024/holding-dog-outdoors.jpg?sc_lang=en&hash=EBE588F623ABC155AD43F491BA25004E',
            bookUrl:
                'https://www.mayoclinichealthsystem.org/hometown-health/speaking-of-health/emotional-exhaustion-during-times-of-unrest',
          ),
        ];
      case 'Anxious':
        return [
          BlogData(
            title: '12 Ways to Calm Your Anxiety',
            description:
                'A practical guide from Healthline that offers evidence-based techniques for managing anxiety. Readers learn breathing exercises, journaling methods, mindfulness practices, and lifestyle adjustments that can help reduce anxious thoughts and regain emotional balance.',
            thumbnailUrl:
                'https://media.post.rvohealth.io/wp-content/uploads/2026/01/integrity4.jpg',
            bookUrl: 'https://www.healthline.com/health/how-to-calm-anxiety',
          ),

          BlogData(
            title: 'Effective Coping Techniques for Anxiety',
            description:
                'This article explores actionable strategies for coping with anxiety in daily life. It covers breathing exercises, physical activity, journaling, and long-term habits that can improve mental well-being and reduce overwhelming worry.',
            thumbnailUrl:
                'https://media.post.rvohealth.io/wp-content/uploads/2026/06/blood_pressure-thumbnail-732x549-1.jpg',
            bookUrl:
                'https://www.healthline.com/health/mental-health/medicine-and-self-care-for-anxiety',
          ),

          BlogData(
            title: '8 Ways To Calm Your Anxiety in the Moment',
            description:
                'A Cleveland Clinic guide written by mental health experts. It focuses on practical techniques that can quickly reduce anxiety, including deep breathing, grounding exercises, positive self-talk, and managing negative thought patterns.',
            thumbnailUrl:
                'https://assets.clevelandclinic.org/transform/LargeFeatureImage/ef17e33f-d829-48f8-9b94-b6783f187b07/walking-outdoors-2184231568',
            bookUrl: 'https://health.clevelandclinic.org/how-to-calm-anxiety',
          ),

          BlogData(
            title: 'How to Use Mindfulness for Anxiety',
            description:
                'A Calm article that teaches seven mindfulness techniques designed to help people stay grounded when their minds become overwhelmed by worry. Ideal for users looking for practical and gentle anxiety relief.',
            thumbnailUrl:
                'https://images.squarespace-cdn.com/content/v1/656f4e4dababbd7c042c4946/1530a471-cf65-4641-ba26-952b79ff2889/mindfulness+for+anxiety-3x2.jpg?format=2500w',
            bookUrl: 'https://www.calm.com/blog/mindfulness-for-anxiety',
          ),

          BlogData(
            title: 'How to Manage Fear and Anxiety',
            description:
                'Published by the Mental Health Foundation, this resource explains the difference between fear and anxiety while providing self-help strategies, coping tools, and guidance for seeking support when needed.',
            thumbnailUrl:
                'https://www.mentalhealth.org.uk/sites/default/files/styles/750_x_450_mhf_theme/public/2025-01/RS34_mhf-33-view-of-nature.jpg?h=87d750eb&itok=tKCmf7bc',
            bookUrl:
                'https://www.mentalhealth.org.uk/how-overcome-anxiety-and-fear',
          ),

          BlogData(
            title: 'Anxiety: What It Is, What To Do',
            description:
                'A Harvard Health article that explains how anxiety affects the brain and body, why it happens, and what practical steps can be taken to manage it. Written in a reassuring and easy-to-understand style.',
            thumbnailUrl:
                'https://domf5oio6qrcr.cloudfront.net/medialibrary/9475/iStock-693982796.jpg',
            bookUrl:
                'https://www.health.harvard.edu/blog/anxiety-what-it-is-what-to-do-2018060113955',
          ),

          BlogData(
            title: 'How to Use Mindfulness to Reduce Anxiety',
            description:
                'A detailed guide explaining how mindfulness helps interrupt cycles of worry and stress. It provides practical exercises and examples that many readers have found useful for calming anxious thoughts.',
            thumbnailUrl:
                'https://www.calmclinic.com/storage/images/556/rhs0uu/main/w1600.webp',
            bookUrl: 'https://www.calmclinic.com/anxiety/mindfulness',
          ),
        ];
      case 'Frustrated':
        return [
          BlogData(
            title: '12 Ways to Cope With Frustration',
            description:
                'A detailed Psychology Today article explaining why frustration happens and offering practical strategies such as mindfulness, emotional regulation, and problem-solving. Ideal for people who feel stuck, irritated, or blocked from reaching their goals.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1516302752625-fcc3c50ae61f?w=800',
            bookUrl:
                'https://www.psychologytoday.com/us/blog/evolution-of-the-self/202408/12-effective-ways-to-cope-with-frustration',
          ),

          BlogData(
            title: 'The Key to Coping With Frustration',
            description:
                'This Psychology Today article explains that frustration often comes from unmet expectations. It teaches readers how to recognize unrealistic expectations and adjust them to reduce emotional distress.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
            bookUrl:
                'https://www.psychologytoday.com/us/blog/flex-your-feelings/202208/the-key-coping-frustration',
          ),

          BlogData(
            title: '5 Steps to Overcoming Frustration',
            description:
                'A Psych Central guide that provides concrete techniques such as identifying triggers, journaling, physical activity, and self-care to prevent frustration from escalating into anger or helplessness.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
            bookUrl:
                'https://psychcentral.com/health/steps-to-overcoming-frustration',
          ),

          BlogData(
            title: 'Signs of Frustration',
            description:
                'A WebMD article explaining the causes, symptoms, and effects of frustration. It helps readers understand how frustration develops and what can be done before it begins affecting mental well-being.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
            bookUrl: 'https://www.webmd.com/mental-health/signs-frustration',
          ),

          BlogData(
            title: 'Five Science-Backed Strategies to Build Resilience',
            description:
                'Frustration often follows setbacks and obstacles. This Greater Good Magazine article focuses on building resilience so that challenges become opportunities for growth rather than sources of ongoing irritation.',
            thumbnailUrl:
                'https://ggsc.s3.us-west-2.amazonaws.com/assets/images/heart_-_abcdef_-_b5a6588aa0402433fda311fa1a0782b0f6623c94.webp',
            bookUrl:
                'https://greatergood.berkeley.edu/article/item/five_science_backed_strategies_to_build_resilience',
          ),
        ];
      case 'Angry':
        return [
          BlogData(
            title: 'Anger Management: 10 Tips to Tame Your Temper',
            description:
                'A practical guide from Mayo Clinic that teaches evidence-based anger management techniques including time-outs, exercise, communication skills, forgiveness, and relaxation methods. One of the most trusted resources for learning how to calm anger before it causes harm.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800',
            bookUrl:
                'https://www.mayoclinic.org/healthy-lifestyle/adult-health/in-depth/anger-management/art-20045434',
          ),

          BlogData(
            title: 'Let Go of Your Anger: Take Back Control of Your Life',
            description:
                'A helpful article about recognizing when anger becomes harmful and learning practical ways to release it. Includes breathing exercises, trigger awareness, and techniques for restoring emotional balance.',
            thumbnailUrl:
                'https://cdn2.psychologytoday.com/assets/default_images/counseling.jpg',
            bookUrl:
                'https://www.psychologytoday.com/us/blog/trial-triumph/202109/let-go-your-anger-take-back-control-your-life',
          ),

          BlogData(
            title: '6 Ways to Take Control Back From Anger',
            description:
                'Focuses on self-care, perspective, emotional regulation, and healthy coping skills. Especially useful for people who frequently feel irritated, resentful, or overwhelmed by anger.',
            thumbnailUrl:
                'https://cdn2.psychologytoday.com/assets/styles/article_inline_full_caption/public/field_blog_entry_images/2022-02/pexels-shvets_production.jpeg.jpg?itok=sA-PDsPH',
            bookUrl:
                'https://www.psychologytoday.com/us/blog/mental-health-nerd/202202/6-ways-to-take-control-back-from-anger',
          ),

          BlogData(
            title: 'Anger Management: What It Is, Skills & Techniques',
            description:
                'A Cleveland Clinic guide explaining how anger affects mental and physical health. It introduces communication techniques, relaxation skills, and coping strategies that can help people respond more constructively.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
            bookUrl:
                'https://my.clevelandclinic.org/health/diseases/12195-anger-management/',
          ),

          BlogData(
            title: 'Anger Management Techniques and Tips',
            description:
                'A straightforward WebMD resource that explains the causes of anger and practical ways to manage it. Ideal for users looking for simple, actionable advice.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
            bookUrl: 'https://www.webmd.com/mental-health/anger-management',
          ),

          BlogData(
            title: 'How to Control Anger: 25 Tips to Help You Stay Calm',
            description:
                'One of Healthline’s most popular anger-management articles. Covers breathing exercises, mindfulness, reframing thoughts, communication skills, and other practical techniques for staying calm.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1482192505345-5655af888cc4?w=800',
            bookUrl:
                'https://www.healthline.com/health/mental-health/how-to-control-anger',
          ),
        ];
      case 'Hopeless':
        return [
          BlogData(
            title: 'Feeling Hopeless? 7 Ways to Support Yourself',
            description:
                'A Healthline article that explains how hopelessness develops and provides practical strategies for rebuilding hope. It encourages readers to take small actions, stay connected with others, and focus on what can be controlled in the present moment.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
            bookUrl: 'https://www.healthline.com/health/feeling-hopeless',
          ),

          BlogData(
            title: 'Finding Hope',
            description:
                'This Psychology Today article explores the concept of learned helplessness and explains how people can regain hope after repeated setbacks. It includes actionable suggestions such as finding role models, taking small steps, and practicing kindness.',
            thumbnailUrl:
                'https://cdn2.psychologytoday.com/assets/styles/manual_crop_3_2_600x400/public/teaser_image/blog_entry/2026-04/pexels-sky-miller-103843835-9790290.jpg?itok=vj7tzI2E',
            bookUrl:
                'https://www.psychologytoday.com/us/blog/pieces-of-mind/201504/finding-hope',
          ),

          BlogData(
            title: 'How to Develop Hope When You Feel Hopeless',
            description:
                'Written by mental strength expert Amy Morin, this article provides science-backed techniques for cultivating hope. It explains how hope differs from wishful thinking and how small actions can create a more positive future.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1482192505345-5655af888cc4?w=800',
            bookUrl:
                'https://www.psychologytoday.com/us/blog/what-mentally-strong-people-dont-do/202306/how-to-develop-hope-when-you-feel-hopeless',
          ),

          BlogData(
            title: 'The Importance of Hope for Mental Health',
            description:
                'An article discussing how hope influences resilience, motivation, and emotional recovery. It highlights practical ways to strengthen hope even during difficult periods of life.',
            thumbnailUrl:
                'https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_288x288/public/field_blog_entry_teaser_image/2021-05/tamas-pap-4pywyal_nli-unsplash.jpg?itok=0QScEC40',
            bookUrl: 'https://www.psychologytoday.com/us/blog/hope-resilience',
          ),

          BlogData(
            title: 'How Resilience Helps You Recover From Adversity',
            description:
                'A guide to understanding resilience and developing the ability to bounce back from hardship. Particularly helpful for people who feel defeated or stuck after repeated disappointments.',
            thumbnailUrl:
                'https://www.apa.org/images/resilience-topic-tile_tcm7-305099_w640_n.jpg',
            bookUrl: 'https://www.apa.org/topics/resilience',
          ),
        ];
      default:
        return [
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
        ];
    }
  }

  Widget _buildBlogContainer(BlogData blog, Color accent, bool isLight) {
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

                GestureDetector(
                  onTap: () => _showDescriptionDialog(
                    title: blog.title,
                    description: blog.description,
                    link: blog.bookUrl,
                  ),
                  child: Text(
                    blog.description,
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
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return _buildBlogContainer(blog, accent, isLight);
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
