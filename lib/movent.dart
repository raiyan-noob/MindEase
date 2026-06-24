import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieData {
  final String title;
  final String description;
  final String thumbnailUrl; // URL or asset path
  final String videoUrl;

  MovieData({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
  });
}

class MovieEntPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const MovieEntPage({
    super.key,
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<MovieEntPage> createState() => _MovieEntPageState();
}

class _MovieEntPageState extends State<MovieEntPage>
    with WidgetsBindingObserver {
  late final List<MovieData> movies;
  bool _pendingShowRating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    movies = _getMovieDataForFeeling(widget.feeling);
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

  List<MovieData> _getMovieDataForFeeling(String feeling) {
    switch (feeling) {
      case 'Sad':
        return [
          MovieData(
            title: 'The Pursuit of Happyness',
            description:
                'A deeply inspiring story about perseverance, hope, and a father’s love. Perfect for reminding yourself that difficult times are temporary and that persistence can lead to brighter days.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw500%2FzHNlrkRUUeDoKPWekjQikb3gMPC.png&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.app/movie/1402',
          ),

          MovieData(
            title: 'A Man Called Otto',
            description:
                'A touching and heartwarming film about loneliness, healing, friendship, and rediscovering purpose in life. It starts emotionally heavy but leaves viewers feeling hopeful.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/130H1gap9lFfiTF9iDrqNIkFvC9.jpg',
            videoUrl: 'https://www.cineby.app/movie/937278',
          ),

          MovieData(
            title: 'Forrest Gump',
            description:
                'An uplifting journey through life filled with kindness, resilience, and unforgettable moments. Forrest’s optimism can be surprisingly comforting during periods of sadness.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
            videoUrl: 'https://www.cineby.app/movie/13',
          ),

          MovieData(
            title: 'Soul',
            description:
                'A beautiful animated movie about purpose, appreciating life, and finding joy in everyday moments. Many viewers describe it as therapeutic during difficult emotional periods.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/hm58Jw4Lw8OIeECIq5qyPYhAeRJ.jpg',
            videoUrl: 'https://www.cineby.app/movie/508442',
          ),

          MovieData(
            title: 'Kiki’s Delivery Service',
            description:
                'A cozy Studio Ghibli film about self-discovery, independence, and overcoming self-doubt. Its gentle atmosphere makes it an excellent comfort watch.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw500%2FtceNr5IuyrqQswjyb0p6SknnhG2.png&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.app/movie/16859',
          ),

          MovieData(
            title: 'Barakamon',
            description:
                'A wholesome anime about a burnt-out artist who finds healing, friendship, and joy in a small rural community. Lighthearted, funny, and surprisingly emotional.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw300%2Fx6Vk2gAR7FR1A3hrOnTJRRHBn6u.jpg&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.at/tv/67048',
          ),

          MovieData(
            title: 'Ted Lasso',
            description:
                'A heartwarming series filled with optimism, kindness, humor, and emotional growth. Frequently recommended by viewers struggling with sadness or loneliness.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/5fhZdwP1DVJ0FyVH6vrFdHwpXIn.jpg',
            videoUrl: 'https://www.cineby.app/tv/97546',
          ),
        ];
      case 'Depressed':
        return [
          MovieData(
            title: 'The Secret Life of Walter Mitty',
            description:
                'A shy man trapped in routine discovers courage, purpose, and adventure. This uplifting journey reminds viewers that life can still hold beauty, meaning, and unexpected opportunities even when they feel stuck.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw500%2FiBvmyOYch3qFY27KSETOYbpLqYZ.png&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.at/movie/116745',
          ),
          MovieData(
            title: 'The Pursuit of Happyness',
            description:
                'A deeply inspiring story about perseverance, hope, and a father’s love. Perfect for reminding yourself that difficult times are temporary and that persistence can lead to brighter days.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw500%2FzHNlrkRUUeDoKPWekjQikb3gMPC.png&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.app/movie/1402',
          ),
          MovieData(
            title: 'Forrest Gump',
            description:
                'An uplifting journey through life filled with kindness, resilience, and unforgettable moments. Forrest’s optimism can be surprisingly comforting during periods of sadness.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
            videoUrl: 'https://www.cineby.app/movie/13',
          ),

          MovieData(
            title: 'Soul',
            description:
                'A beautiful animated movie about purpose, appreciating life, and finding joy in everyday moments. Many viewers describe it as therapeutic during difficult emotional periods.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/hm58Jw4Lw8OIeECIq5qyPYhAeRJ.jpg',
            videoUrl: 'https://www.cineby.app/movie/508442',
          ),
          MovieData(
            title: 'A Silent Voice',
            description:
                'A powerful anime film about guilt, loneliness, forgiveness, and second chances. It explores depression and self-worth in a compassionate way while offering a hopeful message of healing and connection.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/tuFaWiqX0TXoWu7DGNcmX3UW7sT.jpg',
            videoUrl: 'https://www.cineby.at/movie/378064',
          ),
          MovieData(
            title: 'Barakamon',
            description:
                'A wholesome anime about a burnt-out artist who finds healing, friendship, and joy in a small rural community. Lighthearted, funny, and surprisingly emotional.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw300%2Fx6Vk2gAR7FR1A3hrOnTJRRHBn6u.jpg&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.at/tv/67048',
          ),

          MovieData(
            title: 'Ted Lasso',
            description:
                'A heartwarming series filled with optimism, kindness, humor, and emotional growth. Frequently recommended by viewers struggling with sadness or loneliness.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/5fhZdwP1DVJ0FyVH6vrFdHwpXIn.jpg',
            videoUrl: 'https://www.cineby.app/tv/97546',
          ),
        ];
      case 'Anxious':
        return [
          MovieData(
            title: 'My Neighbor Totoro',
            description:
                'A gentle Studio Ghibli classic filled with wonder, nature, and childhood innocence. Its calming atmosphere and heartwarming moments make it a favorite comfort film for people dealing with anxiety and stress.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg',
            videoUrl: 'https://www.cineby.at/movie/8392',
          ),

          MovieData(
            title: 'Kiki’s Delivery Service',
            description:
                'A comforting story about self-discovery, independence, and overcoming self-doubt. Kiki’s journey reminds viewers that feeling overwhelmed is normal and that confidence grows with patience and perseverance.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BOGVkNGEzZmUtOGUwMS00MDFiLWJjNzAtNzg3NGE5MmI0ZGMyXkEyXkFqcGdeQXRyYW5zY29kZS13b3JrZmxvdw@@._V1_.jpg',
            videoUrl: 'https://www.cineby.at/movie/16859',
          ),

          MovieData(
            title: 'Barakamon',
            description:
                'A wholesome anime about a burnt-out artist who finds healing, friendship, and joy in a small rural community. Lighthearted, funny, and surprisingly emotional.',
            thumbnailUrl:
                'https://wsrv.nl/?url=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Fw300%2Fx6Vk2gAR7FR1A3hrOnTJRRHBn6u.jpg&output=webp&q=50&n=-1',
            videoUrl: 'https://www.cineby.at/tv/67048',
          ),

          MovieData(
            title: 'Bluey',
            description:
                'Although designed for children, Bluey is widely loved by adults for its warmth, humor, and positive messages. Its short episodes and wholesome family moments provide a relaxing mental break.',
            thumbnailUrl:
                'https://cdn.iview.abc.net.au/thumbs/1200/ch/CH1702Q_60753d79d7c4d_1920.jpg',
            videoUrl: 'https://www.cineby.at/tv/82728',
          ),

          MovieData(
            title: 'Parks and Recreation',
            description:
                'A feel-good comedy series full of supportive friendships, optimism, and uplifting humor. Its positive tone makes it a popular comfort show during stressful periods.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BNDlhMzAwNTAtNTk2NS00MTdkLWE3ZWYtMDU0MTFiYmU2ZTc0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
            videoUrl: 'https://www.cineby.at/tv/8592',
          ),
        ];
      case 'Frustrated':
        return [
          MovieData(
            title: 'The Pursuit of Happyness',
            description:
                'A powerful true story about perseverance through setbacks, rejection, and hardship. Watching Chris Gardner refuse to give up despite overwhelming obstacles can be incredibly motivating when life feels unfair or frustrating.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BMTQ5NjQ0NDI3NF5BMl5BanBnXkFtZTcwNDI0MjEzMw@@._V1_FMjpg_UX1000_.jpg',
            videoUrl: 'https://www.cineby.at/movie/1402',
          ),

          MovieData(
            title: 'Rocky',
            description:
                'One of the greatest underdog stories ever told. Rocky reminds viewers that success is not about never failing—it is about continuing to move forward despite frustration, doubt, and setbacks.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/8eihUxjQsJ7WvGySkVMC0EwbPAD.jpg',
            videoUrl: 'https://www.cineby.at/movie/1366',
          ),

          MovieData(
            title: 'The Secret Life of Walter Mitty',
            description:
                'A visually beautiful journey about breaking free from routine and self-doubt. Perfect for anyone feeling stuck, frustrated, or trapped by circumstances.',
            thumbnailUrl:
                'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p10016880_p_v12_ap.jpg',
            videoUrl: 'https://www.cineby.at/movie/116745',
          ),

          MovieData(
            title: 'Barakamon',
            description:
                'After a major career setback, a young calligrapher moves to the countryside and slowly rediscovers joy, creativity, and personal growth. Funny, wholesome, and deeply refreshing.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BMWFkYWI4NTctNGU5Yy00YTIxLWFkMGYtMjlmZWE3MjY2MDQ3XkEyXkFqcGc@._V1_.jpg',
            videoUrl: 'https://www.cineby.at/tv/61318',
          ),

          MovieData(
            title: 'Haikyuu!!',
            description:
                'An inspiring sports anime about determination, teamwork, and never giving up after failure. Its energy and positivity make it a fantastic choice for overcoming frustration and regaining motivation.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BYjYxMWFlYTAtYTk0YS00NTMxLWJjNTQtM2E0NjdhYTRhNzE4XkEyXkFqcGc@._V1_.jpg',
            videoUrl: 'https://www.cineby.at/tv/60863',
          ),

          MovieData(
            title: 'Ted Lasso',
            description:
                'A heartwarming series about leadership, resilience, and kindness. Ted’s ability to stay optimistic in difficult situations offers a refreshing perspective when frustration starts taking over.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/5fhZdwP1DVJ0FyVH6vrFdHwpXIn.jpg',
            videoUrl: 'https://www.cineby.at/tv/97546',
          ),

          MovieData(
            title: 'The Karate Kid',
            description:
                'A classic story of discipline, perseverance, and self-improvement. It teaches that frustration is often part of the learning process and that growth comes from persistence.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BMTQ0ODg3ODEyMF5BMl5BanBnXkFtZTcwNjI1MTgxMw@@._V1_FMjpg_UX1000_.jpg',
            videoUrl: 'https://www.cineby.at/movie/1885',
          ),
        ];
      case 'Angry':
        return [
          MovieData(
            title: 'Good Will Hunting',
            description:
                'A powerful story about a troubled young man learning to confront his past, manage his emotions, and accept help from others. The film beautifully explores healing, forgiveness, and emotional growth.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/z2FnLKpFi1HPO7BEJxdkv6hpJSU.jpg',
            videoUrl: 'https://www.cineby.at/movie/489',
          ),

          MovieData(
            title: 'The Intouchables',
            description:
                'An uplifting French film about an unlikely friendship that changes two lives. Its humor, warmth, and message of empathy can help shift focus away from anger and toward human connection.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/323BP0itpxTsO0skTwdnVmf7YC9.jpg',
            videoUrl: 'https://www.cineby.at/movie/77338',
          ),

          MovieData(
            title: 'Silver Linings Playbook',
            description:
                'A heartfelt story about overcoming emotional struggles, rebuilding relationships, and learning healthier ways to cope with life\'s frustrations. Funny, hopeful, and surprisingly therapeutic.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/y7iOVneBvITlBdhy6tVqXVOa1Js.jpg',
            videoUrl: 'https://www.cineby.at/movie/82693',
          ),

          MovieData(
            title: 'The Peanut Butter Falcon',
            description:
                'A wholesome adventure filled with kindness, friendship, and self-discovery. Its positive energy and lovable characters make it an excellent choice when trying to let go of anger.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYAEkWAqKOOGyskZDDR3tZRFIzreJeTkWy2g&s',
            videoUrl: 'https://www.cineby.at/movie/463257',
          ),

          MovieData(
            title: 'The Way Way Back',
            description:
                'A coming-of-age comedy-drama about finding confidence, support, and belonging. Its uplifting tone and emotional warmth make it a great antidote to lingering anger and resentment.',
            thumbnailUrl:
                'https://m.media-amazon.com/images/M/MV5BNTU5ODk5NDg0Nl5BMl5BanBnXkFtZTcwNzQwMjI1OQ@@._V1_.jpg',
            videoUrl: 'https://www.cineby.at/movie/147773',
          ),
        ];
      case 'Hopeless':
        return [
          MovieData(
            title: 'The Shawshank Redemption',
            description:
                'One of the most inspiring stories ever told about hope and perseverance. Despite years of hardship and isolation, Andy never gives up on the possibility of a better future, reminding viewers that hope can survive even the darkest circumstances.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg',
            videoUrl: 'https://www.cineby.at/movie/278',
          ),

          MovieData(
            title: 'Life of Pi',
            description:
                'A visually stunning journey of survival, faith, and resilience. Through impossible challenges and uncertainty, the story encourages viewers to keep believing even when the path ahead seems unclear.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/iLgRu4hhSr6V1uManX6ukDriiSc.jpg',
            videoUrl: 'https://www.cineby.at/movie/87827',
          ),

          MovieData(
            title: 'Anne with an E',
            description:
                'A beautiful series about an optimistic orphan girl who transforms the lives of everyone around her. Filled with warmth, hope, friendship, and personal growth.',
            thumbnailUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WKUl7MUsM02AqX6fTtUdY8jvlr1eoqryeA&s',
            videoUrl: 'https://www.cineby.at/tv/70785',
          ),

          MovieData(
            title: 'The Boy, the Mole, the Fox and the Horse',
            description:
                'A gentle and uplifting animated story filled with wisdom about courage, friendship, kindness, and hope. Perfect for moments when life feels overwhelming or directionless.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/oQRgyQCzcyZvE6w5heM9ktVY0LT.jpg',
            videoUrl: 'https://www.cineby.at/movie/995133',
          ),

          MovieData(
            title: 'Hidden Figures',
            description:
                'Based on a true story, this inspiring film follows three brilliant women who overcome enormous obstacles through determination, intelligence, and resilience. A powerful reminder not to give up.',
            thumbnailUrl:
                'https://image.tmdb.org/t/p/w500/9lfz2W2uGjyow3am00rsPJ8iOyq.jpg',
            videoUrl: 'https://www.cineby.at/movie/381284',
          ),
        ];
      default:
        return [
          MovieData(
            title: 'Inside Out 2',
            description:
                'Join Riley as she navigates new emotions during adolescence — a fun and heartfelt look at mental health for all ages.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1616530940355-351fabd9524b?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=LEjhY15eCx0',
          ),
          MovieData(
            title: 'Soul',
            description:
                'A Pixar masterpiece exploring the meaning of life, purpose, and what truly makes us feel alive.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=xOsLIiBStEs',
          ),
          MovieData(
            title: 'A Beautiful Mind',
            description:
                'The inspiring story of John Nash\'s journey through mental illness and his triumph over schizophrenia.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=9wZMbOvzVEo',
          ),
          MovieData(
            title: 'Silver Linings Playbook',
            description:
                'A heartwarming dramedy about two people managing mental health struggles who find hope in each other.',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400&h=300&fit=crop',
            videoUrl: 'https://www.youtube.com/watch?v=Lj5_FhLaaQQ',
          ),
        ];
    }
  }

  Widget _buildMovieContainer(MovieData movie, Color accent, bool isLight) {
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
            onTap: () => _launchURL(movie.videoUrl),
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
                    movie.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: accent.withOpacity(0.2),
                        child: Icon(Icons.play_circle, color: accent, size: 40),
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
                    movie.title,
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
                    title: movie.title,
                    description: movie.description,
                    link: movie.videoUrl,
                  ),
                  child: Text(
                    movie.description,
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
                '🎬 Movies & Videos',
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
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _buildMovieContainer(movie, accent, isLight);
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
