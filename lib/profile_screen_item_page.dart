import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const History({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text('Mood History', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Center(
            child: Text(
              'Mood History Page',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}

class Security extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const Security({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text('Security', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Center(
            child: Text('Security Page', style: TextStyle(color: textColor)),
          ),
        );
      },
    );
  }
}

class Announcements extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const Announcements({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text('Activities', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Center(
            child: Text('Activities Page', style: TextStyle(color: textColor)),
          ),
        );
      },
    );
  }
}

class SocialAndExtras extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const SocialAndExtras({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<SocialAndExtras> createState() => _SocialAndExtrasState();
}

class _SocialAndExtrasState extends State<SocialAndExtras> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text(
              'Social & Extras',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Text(
              'Social & Extras Page',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}

class InviteFriends extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const InviteFriends({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text(
              'Invite Friends',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Text(
              'Invite Friends Page',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}

class PrivacyPolicy extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const PrivacyPolicy({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Text(
              'Privacy Policy Page',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}

class ContactUs extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const ContactUs({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ? const Color.fromRGBO(0, 152, 139, 1)
                : const Color(0xFF193022),
            title: Text('Contact Us', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Center(
            child: Text('Contact Us Page', style: TextStyle(color: textColor)),
          ),
        );
      },
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        centerTitle: true,
        title: const Text(
          "View Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "rejwanul islam",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Rejwanulrakib23@gmail.com",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "01799236603",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "DOB",
                hintText: "2004-10-23",
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "uttara",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Go Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
