import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

/// Library has yet to support null-safety
/// Add argumesnts--no-sound-null-safety
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui' as ui;

void main() {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
      'hello-world-html',
      (int viewId) => IFrameElement()
        // ..width = '640'
        // ..height = '360'
        ..src = Constants.webUserTopLanguages
        ..style.border = 'none');

  /// Removes hash/pound (#) sign on the root URL
  // setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.socialName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Constants {
  static const socialName = "Omatt";
  static const description =
      "Software Engineer (Android, Flutter) \npassionate in opensource tech and latest computing trends.\nLikes tinkering stuff and mechanical keyboards.";

  static const userLinkStackOverflow =
      'https://stackoverflow.com/users/2497859/omatt';
  static const userLinkGitHub = 'https://github.com/omatt';
  static const userLinkLinkedIn = 'https://linkedin.com/in/omarmatthewreyes';

  static const webUserTopLanguages =
      'https://github-readme-stats.vercel.app/api/top-langs/?username=omatt&layout=compact&exclude_repo=LetterCounter,OOP-Concepts,SimpleJavaExercises,SampleUpButton,Palindrome,Methods,RTMP-stream-demo,PG-Tracker-App,dpshack2018';
  static const markdownUserTopLanguages =
      '[![Top Languages](https://github-readme-stats.vercel.app/api/top-langs/?username=omatt&layout=compact&exclude_repo=LetterCounter,OOP-Concepts,SimpleJavaExercises,SampleUpButton,Palindrome,Methods,RTMP-stream-demo,PG-Tracker-App,dpshack2018)](https://github.com/omatt)';

  static const paddingNormal = 32.0;
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Constants.paddingNormal,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/omarmatthew.jpeg'),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Constants.paddingNormal,
                ),
                Text(
                  Constants.socialName,
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Constants.paddingNormal,
                ),
                Text(
                  Constants.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      letterSpacing: 0),
                ),
                SizedBox(
                  height: Constants.paddingNormal,
                ),
                topLangWidget(),
                // MarkdownBody(data: Constants.markdownUserTopLanguages),
                SizedBox(
                  height: Constants.paddingNormal,
                ),
                Container(
                  width: 150,
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: Constants.paddingNormal,
                ),
                SocialButton(
                  url: Constants.userLinkStackOverflow,
                  icon: MdiIcons.stackOverflow,
                  iconColor: Colors.deepOrangeAccent,
                  label: "Stack Overflow",
                ),
                const SizedBox(
                  height: Constants.paddingNormal,
                ),
                SocialButton(
                  url: Constants.userLinkGitHub,
                  icon: MdiIcons.github,
                  iconColor: Colors.black,
                  label: "GitHub profile",
                ),
                const SizedBox(
                  height: Constants.paddingNormal,
                ),
                SocialButton(
                  url: Constants.userLinkLinkedIn,
                  icon: MdiIcons.linkedin,
                  iconColor: Colors.blue,
                  label: "LinkedIn profile",
                ),
                SizedBox(
                  height: Constants.paddingNormal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  topLangWidget() {
    return SizedBox(
      width: 360,
      height: 200,
      child: HtmlElementView(viewType: 'hello-world-html'),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.url,
    required this.icon,
    required this.iconColor,
    required this.label,
  }) : super(key: key);

  final String url;
  final IconData icon;
  final Color iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextButton(
        onPressed: () => _launchURL(url),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        )),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(3),
          minimumSize: MaterialStateProperty.all(Size(200, 80)),
          overlayColor: MaterialStateProperty.all(Colors.grey[100]),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Color(0xFF000028)),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
