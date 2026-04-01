import 'package:flutter/material.dart';
import 'dart:async';
import 'package:splash_design/1stpage.dart';

import 'profile/profile_screen_main.dart';

enum SessionState { intro, running, paused }

class BreathingPage extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const BreathingPage({
    Key? key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  }) : super(key: key);
  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 2;
  late AnimationController _navAnimController;
  late Animation<double> _navBounceAnimation;

  static const int _totalSeconds = 60;
  int _remainingSeconds = _totalSeconds;
  Timer? _countdownTimer;
  SessionState _sessionState = SessionState.intro;
  bool _isBreathingIn = true;

  late AnimationController _breatheController;
  late Animation<double> _scaleAnimation;
  late AnimationController _introFadeController;
  late Animation<double> _introFadeAnim;
  late Animation<Offset> _introSlideAnim;
  late AnimationController _sessionFadeController;
  late Animation<double> _sessionFadeAnim;

  @override
  void initState() {
    super.initState();

    _navAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _navBounceAnimation = CurvedAnimation(
      parent: _navAnimController,
      curve: Curves.elasticOut,
    );
    _navAnimController.forward();

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _scaleAnimation = Tween<double>(begin: 0.78, end: 1.0).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );
    _breatheController.addStatusListener((status) {
      if (!mounted) return;
      if (status == AnimationStatus.completed) {
        setState(() => _isBreathingIn = false);
        _breatheController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _isBreathingIn = true);
        _breatheController.forward();
      }
    });

    _introFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _introFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introFadeController, curve: Curves.easeOut),
    );
    _introSlideAnim =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(parent: _introFadeController, curve: Curves.easeOut),
        );

    _sessionFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _sessionFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _sessionFadeController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _introFadeController.forward();
    });
  }

  @override
  void dispose() {
    _navAnimController.dispose();
    _countdownTimer?.cancel();
    _breatheController.dispose();
    _introFadeController.dispose();
    _sessionFadeController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    _introFadeController.reverse().then((_) {
      if (!mounted) return;
      setState(() {
        _sessionState = SessionState.running;
        _remainingSeconds = _totalSeconds;
        _isBreathingIn = true;
      });
      _sessionFadeController.forward(from: 0);
      _breatheController.forward(from: 0);
      _startCountdown();
    });
  }

  bool get _isBreathingPageActive {
    if (!mounted) return false;
    final route = ModalRoute.of(context);
    return route?.isCurrent ?? false;
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        _breatheController.stop();

        // Show the appreciation dialog only when this page is currently visible.
        if (_isBreathingPageActive) {
          _showCompletionDialog();
        }
      }
    });
  }

  void _togglePause() {
    if (_sessionState == SessionState.paused) {
      setState(() => _sessionState = SessionState.running);
      _breatheController.forward();
      _startCountdown();
    } else {
      setState(() => _sessionState = SessionState.paused);
      _countdownTimer?.cancel();
      _breatheController.stop();
    }
  }

  void _endSessionEarly() {
    final int done = _totalSeconds - _remainingSeconds;
    _countdownTimer?.cancel();
    _breatheController.stop();
    _showEarlyEndDialog(done);
  }

  void _resetToIntro() {
    _countdownTimer?.cancel();
    _breatheController.stop();
    _breatheController.reset();
    _sessionFadeController.reset();
    setState(() {
      _remainingSeconds = _totalSeconds;
      _sessionState = SessionState.intro;
      _isBreathingIn = true;
    });
    _introFadeController.forward(from: 0);
  }

  String get _formattedTime {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  double _circleSize(BuildContext c) {
    final d = MediaQuery.of(c).size.shortestSide;
    if (d < 600) return 200;
    if (d < 700) return 240;
    return 300;
  }

  //dialogs
  void _showCompletionDialog() {
    if (!_isBreathingPageActive) return;

    final isLight = widget.isLightNotifier.value;
    final textMain = isLight
        ? const Color(0xFF0F5132)
        : const Color(0xFFB8DCC1);
    final subtle = isLight ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);
    final bgColor = isLight ? Colors.white : const Color(0xFF1E1E1E);
    final iconBg = isLight ? const Color(0xFFEAF7EF) : const Color(0xFF193022);
    final border = isLight ? const Color(0xFFE7F3EC) : const Color(0xFF2A2A2A);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: bgColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: border),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [textMain, textMain.withOpacity(0.5)],
                    ),
                  ),
                  child: const Icon(
                    Icons.self_improvement_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '🎉 Bravo! You Did It!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: textMain,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'You just invested a full minute in your peace of mind. Every breath brought you closer to calm. Carry this stillness with you. 🌿',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: subtle,
                    height: 1.5,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '"I meditate. I breathe out what I can\'t control \nand focus on the positives."\n— Deepika Padukone',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: subtle.withOpacity(0.8),
                      height: 1.5,
                      fontFamily: 'Nunito',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _resetToIntro();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: textMain,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Future.delayed(
                      const Duration(milliseconds: 200),
                      _onGetStarted,
                    );
                  },
                  child: Text(
                    'Breathe Again',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textMain,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEarlyEndDialog(int sec) {
    final isLight = widget.isLightNotifier.value;
    final textMain = isLight
        ? const Color(0xFF0F5132)
        : const Color(0xFFB8DCC1);
    final subtle = isLight ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);
    final bgColor = isLight ? Colors.white : const Color(0xFF1E1E1E);
    final iconBg = isLight ? const Color(0xFFEAF7EF) : const Color(0xFF193022);
    final border = isLight ? const Color(0xFFE7F3EC) : const Color(0xFF2A2A2A);
    final warn = isLight ? const Color(0xFF0F5132) : const Color(0xFFB8DCC1);

    late String title, emoji, msg, quote;
    late IconData ic;
    if (sec <= 10) {
      title = 'Leaving So Soon?';
      emoji = '🌱';
      ic = Icons.spa_rounded;
      msg =
          'Even a single breath counts. You showed up for yourself, and that\'s what matters.';
      quote =
          '"The journey of a thousand miles\nbegins with a single step."\n— Lao Tzu';
    } else if (sec <= 30) {
      title = 'Great Start!';
      emoji = '💪';
      ic = Icons.favorite_rounded;
      msg =
          'You breathed for $sec seconds of choosing peace over chaos. Every moment adds up.';
      quote = '"To breathe properly is to\n live properly"- Robin Sharma.';
    } else {
      title = 'Almost There!';
      emoji = '🔥';
      ic = Icons.local_fire_department_rounded;
      msg =
          '$sec seconds of pure mindfulness! You are so\n close to the full minute.';
      quote = '"Healing is not linear,\nbut every step forward counts."';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: bgColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: border),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [warn, warn.withOpacity(0.4)],
                    ),
                  ),
                  child: Icon(ic, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 18),
                Text(
                  '$emoji $title',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: textMain,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '⏱ $sec seconds completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: textMain,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  msg,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: subtle,
                    height: 1.5,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    quote,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: subtle.withOpacity(0.8),
                      height: 1.5,
                      fontFamily: 'Nunito',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => _sessionState = SessionState.running);
                      _breatheController.forward();
                      _startCountdown();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: textMain,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue Breathing',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetToIntro();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'End Session',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: subtle,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Text(
                      ' • ',
                      style: TextStyle(
                        color: subtle.withOpacity(0.4),
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          _onGetStarted,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Restart',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: textMain,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //navigation

  void _onNavTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    _navAnimController.reset();
    _navAnimController.forward();

    switch (index) {
      case 0:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => MyAppFirst(
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );

        break;
      case 1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => MyAppFirst(
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfileScreen(
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? const Color(0xFFF7FAF8) : const Color(0xFF121212);
        final textMain = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        final subtle = isLight
            ? const Color(0xFF6B7280)
            : const Color(0xFF9CA3AF);
        final border = isLight
            ? const Color(0xFFE7F3EC)
            : const Color(0xFF2A2A2A);
        final iconBg = isLight
            ? const Color(0xFFEAF7EF)
            : const Color(0xFF193022);
        final btnSecBg = isLight
            ? const Color(0xFFEAF7EF)
            : const Color(0xFF193022);
        final circleMid = isLight
            ? const Color(0xFFDCEFDF)
            : const Color(0xFF22392A);
        final circleInner = isLight
            ? Colors.white.withOpacity(0.75)
            : const Color(0xFF1E1E1E);
        final cSize = _circleSize(context);

        return Scaffold(
          backgroundColor: bg,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/newLogoremovebg.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'MindEase',
                            style: TextStyle(
                              color: textMain,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => widget.onThemeChanged(!isLight),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isLight
                                ? const Color(0xFFEAF7EF)
                                : const Color(0xFF2A2A2A),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(0, 0, 0, 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) =>
                                RotationTransition(turns: anim, child: child),
                            child: Icon(
                              isLight ? Icons.light_mode : Icons.dark_mode,
                              key: ValueKey(isLight),
                              color: textMain,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: _sessionState == SessionState.intro
                ? _buildIntro(
                    bg: bg,
                    textMain: textMain,
                    subtle: subtle,
                    border: border,
                    iconBg: iconBg,
                    isLight: isLight,
                  )
                : _buildSession(
                    bg: bg,
                    textMain: textMain,
                    subtle: subtle,
                    border: border,
                    btnSecBg: btnSecBg,
                    circleMid: circleMid,
                    circleInner: circleInner,
                    cSize: cSize,
                  ),
          ),
          extendBody: true,
          bottomNavigationBar: _buildBottomNav(isLight),
        );
      },
    );
  }

  //intro

  Widget _buildIntro({
    required Color bg,
    required Color textMain,
    required Color subtle,
    required Color border,
    required Color iconBg,
    required bool isLight,
  }) {
    final imgSize = (MediaQuery.of(context).size.width * 0.55).clamp(
      200.0,
      200.0,
    );

    return FadeTransition(
      opacity: _introFadeAnim,
      child: SlideTransition(
        position: _introSlideAnim,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              const SizedBox(height: 16),

              //image
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBg,
                  boxShadow: [
                    BoxShadow(
                      color: textMain.withOpacity(0.08),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Icon(
                      Icons.self_improvement_rounded,
                      size: imgSize * 0.4,
                      color: textMain.withOpacity(0.7),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Find Your Inner Calm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: textMain,
                    fontFamily: 'Nunito',
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Just 1 minute of mindful breathing can lower your heart rate, reduce stress hormones, and bring clarity to your mind.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: subtle,
                    height: 1.55,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),

              SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.format_quote_rounded,
                        color: textMain.withOpacity(0.7),
                        size: 28,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '"Feelings come and go like clouds in a windy sky.\nConscious breathing is my anchor."',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: subtle,
                          height: 1.5,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '— Thich Nhat Hanh',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: textMain.withOpacity(0.8),
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 38),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: _onGetStarted,
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      color: textMain,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: textMain.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                '🕐 Just 1 minute to a calmer you',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: subtle,
                  fontFamily: 'Nunito',
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // session

  Widget _buildSession({
    required Color bg,
    required Color textMain,
    required Color subtle,
    required Color border,
    required Color btnSecBg,
    required Color circleMid,
    required Color circleInner,
    required double cSize,
  }) {
    final isPaused = _sessionState == SessionState.paused;

    return FadeTransition(
      opacity: _sessionFadeAnim,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween(
                              begin: const Offset(0, 0.15),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          ),
                        ),
                        child: Text(
                          isPaused
                              ? 'Paused'
                              : (_isBreathingIn
                                    ? 'Breathe In…'
                                    : 'Breathe Out…'),
                          key: ValueKey(isPaused ? 'p' : '$_isBreathingIn'),
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: textMain,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Text(
                          isPaused
                              ? 'Take your time…'
                              : (_isBreathingIn
                                    ? 'Let the tension melt away'
                                    : 'Release and let go'),
                          key: ValueKey(isPaused ? 'pt' : '${_isBreathingIn}t'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: subtle,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),

                      //circle
                      Expanded(
                        child: Center(
                          child: _BreathingCircle(
                            animation: _scaleAnimation,
                            formattedTime: _formattedTime,
                            remainingSeconds: _remainingSeconds,
                            totalSeconds: _totalSeconds,
                            circleSize: cSize,
                            textMain: textMain,
                            subtle: subtle,
                            bg: bg,
                            circleMid: circleMid,
                            circleInner: circleInner,
                          ),
                        ),
                      ),

                      // buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: _togglePause,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: btnSecBg,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: border),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isPaused
                                            ? Icons.play_arrow_rounded
                                            : Icons.pause_rounded,
                                        color: textMain,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isPaused ? 'Resume' : 'Pause',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: textMain,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: GestureDetector(
                                onTap: _endSessionEarly,
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: textMain,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: textMain.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'End Session',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      Text(
                        textAlign: TextAlign.center,
                        'Keep breathing. If you keep breathing,\neventually something changes."\n- Krishna Das',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: subtle,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav(bool isLight) {
    return Container(
      decoration: BoxDecoration(
        color: isLight
            ? Colors.white.withOpacity(0.95)
            : const Color(0xFF1C1C1C).withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, isLight ? 0.08 : 0.35),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _AnimatedNavItem(
                icon: Icons.home_filled,
                label: "Home",
                index: 0,
                selectedIndex: _selectedIndex,
                isLight: isLight,
                bounceAnimation: _navBounceAnimation,
                onTap: () => _onNavTap(0),
              ),
              _AnimatedNavItem(
                icon: Icons.spa_outlined,
                label: "Heal",
                index: 1,
                selectedIndex: _selectedIndex,
                isLight: isLight,
                bounceAnimation: _navBounceAnimation,
                onTap: () => _onNavTap(1),
              ),
              _AnimatedNavItem(
                icon: Icons.self_improvement_outlined,
                label: "Breathe",
                index: 2,
                selectedIndex: _selectedIndex,
                isLight: isLight,
                bounceAnimation: _navBounceAnimation,
                onTap: () => _onNavTap(2),
              ),
              _AnimatedNavItem(
                icon: Icons.person_outline,
                label: "Profile",
                index: 3,
                selectedIndex: _selectedIndex,
                isLight: isLight,
                bounceAnimation: _navBounceAnimation,
                onTap: () => _onNavTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// breathing circle

class _BreathingCircle extends AnimatedWidget {
  final String formattedTime;
  final int remainingSeconds, totalSeconds;
  final double circleSize;
  final Color textMain, subtle, bg, circleMid, circleInner;

  const _BreathingCircle({
    required Animation<double> animation,
    required this.formattedTime,
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.circleSize,
    required this.textMain,
    required this.subtle,
    required this.bg,
    required this.circleMid,
    required this.circleInner,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final s = (listenable as Animation<double>).value;
    final outer = circleSize * 1.57;
    final mid = circleSize * 1.57;
    final inner = circleSize * 0.8;
    final prog = circleSize * 0.9;

    return Transform.scale(
      scale: s,
      child: SizedBox(
        width: circleSize,
        height: circleSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: outer,
              height: outer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [textMain.withOpacity(0.1), bg.withOpacity(0)],
                ),
              ),
            ),
            Container(
              width: mid,
              height: mid,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleMid.withOpacity(0.6),
                border: Border.all(
                  color: textMain.withOpacity(0.1),
                  width: 1.5,
                ),
              ),
            ),
            Container(
              width: inner,
              height: inner,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleInner,
                border: Border.all(
                  color: textMain.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: textMain.withOpacity(0.06),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: circleSize * 0.20,
                      fontWeight: FontWeight.w900,
                      color: textMain,
                      letterSpacing: -1,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'SECONDS',
                    style: TextStyle(
                      fontSize: circleSize * 0.043,
                      fontWeight: FontWeight.w700,
                      color: subtle,
                      letterSpacing: 2,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: prog,
              height: prog,
              child: CircularProgressIndicator(
                value: remainingSeconds / totalSeconds,
                strokeWidth: 3,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(textMain.withOpacity(0.3)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════ NAV ITEM ═══════════════

class _AnimatedNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index, selectedIndex;
  final bool isLight;
  final Animation<double> bounceAnimation;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.isLight,
    required this.bounceAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sel = index == selectedIndex;
    final activeColor = isLight
        ? const Color(0xFF0F5132)
        : const Color(0xFFB8DCC1);
    final inactiveColor = isLight
        ? const Color(0xFF9CA3AF)
        : const Color(0xFF6B7280);
    final activeBg = isLight
        ? const Color(0xFFEAF7EF)
        : const Color(0xFF193022);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: sel ? 16 : 12, vertical: 8),
        decoration: BoxDecoration(
          color: sel ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: sel ? 0.8 : 1.0, end: sel ? 1.15 : 1.0),
              duration: const Duration(milliseconds: 350),
              curve: Curves.elasticOut,
              builder: (_, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Icon(
                icon,
                size: 24,
                color: sel ? activeColor : inactiveColor,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: sel
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: AnimatedOpacity(
                        opacity: sel ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: activeColor,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
